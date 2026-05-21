// PM Lobby ClientConnection consume `Cyotek.Collections.Generic.CircularBuffer<T>` (PM
// packages.config → Cyotek.Collections.Generic, MIT). El package no está disponible en el
// NuGet feed actual; replico la API mínima necesaria byte-equivalente.
// LANG-ADAPT: misma API pública (`Put(T[], int, int)`, `Get`, `Skip`, `Peek`, `Capacity`,
// `Size`) y semántica circular FIFO. Comportamiento idéntico al original Cyotek 2.0.

using System;

namespace Cyotek.Collections.Generic;

/// <summary>
/// Fixed-capacity FIFO circular buffer. PM `Cyotek.Collections.Generic.CircularBuffer<T>`
/// equivalent (MIT-license replica of public API surface).
/// </summary>
public class CircularBuffer<T>
{
    private T[] _buffer;
    private int _capacity;
    private int _head;
    private int _tail;
    private int _size;
    private bool _allowOverwrite;

    public CircularBuffer(int capacity) : this(capacity, false) { }

    public CircularBuffer(int capacity, bool allowOverwrite)
    {
        if (capacity < 0) throw new ArgumentException("capacity must be >= 0", nameof(capacity));
        _buffer = new T[capacity];
        _capacity = capacity;
        _head = 0;
        _tail = 0;
        _size = 0;
        _allowOverwrite = allowOverwrite;
    }

    public int Capacity
    {
        get => _capacity;
        set
        {
            if (value == _capacity) return;
            if (value < _size) throw new ArgumentException("new capacity smaller than current size");
            var newBuffer = new T[value];
            if (_size > 0) CopyTo(newBuffer);
            _buffer = newBuffer;
            _capacity = value;
            _head = 0;
            _tail = _size % value;
        }
    }

    public int Size => _size;

    public bool AllowOverwrite { get => _allowOverwrite; set => _allowOverwrite = value; }

    public bool IsEmpty => _size == 0;
    public bool IsFull => _size == _capacity;

    public void Clear()
    {
        _head = 0;
        _tail = 0;
        _size = 0;
        Array.Clear(_buffer, 0, _capacity);
    }

    public int Put(T[] source) => Put(source, 0, source.Length);

    public int Put(T[] source, int offset, int count)
    {
        if (!_allowOverwrite && count > _capacity - _size)
            throw new InvalidOperationException("buffer does not have sufficient capacity to put new items.");
        int srcIndex = offset;
        for (int i = 0; i < count; i++)
        {
            Put(source[srcIndex++]);
        }
        return count;
    }

    public void Put(T item)
    {
        if (_size == _capacity)
        {
            if (!_allowOverwrite)
                throw new InvalidOperationException("buffer is full.");
            // overwrite oldest
            _head = (_head + 1) % _capacity;
            _size--;
        }
        _buffer[_tail] = item;
        _tail = (_tail + 1) % _capacity;
        _size++;
    }

    public T Get()
    {
        if (_size == 0) throw new InvalidOperationException("buffer is empty.");
        T item = _buffer[_head];
        _buffer[_head] = default!;
        _head = (_head + 1) % _capacity;
        _size--;
        return item;
    }

    public int Get(T[] destination) => Get(destination, 0, destination.Length);

    public int Get(T[] destination, int offset, int count)
    {
        int taken = Math.Min(count, _size);
        for (int i = 0; i < taken; i++)
        {
            destination[offset + i] = Get();
        }
        return taken;
    }

    public T Peek()
    {
        if (_size == 0) throw new InvalidOperationException("buffer is empty.");
        return _buffer[_head];
    }

    public T[] Peek(int count)
    {
        if (count > _size) count = _size;
        var result = new T[count];
        int idx = _head;
        for (int i = 0; i < count; i++)
        {
            result[i] = _buffer[idx];
            idx = (idx + 1) % _capacity;
        }
        return result;
    }

    public int Skip(int count)
    {
        int skipped = Math.Min(count, _size);
        for (int i = 0; i < skipped; i++)
        {
            _buffer[_head] = default!;
            _head = (_head + 1) % _capacity;
            _size--;
        }
        return skipped;
    }

    public T[] ToArray()
    {
        var result = new T[_size];
        CopyTo(result);
        return result;
    }

    private void CopyTo(T[] target)
    {
        int idx = _head;
        for (int i = 0; i < _size; i++)
        {
            target[i] = _buffer[idx];
            idx = (idx + 1) % _capacity;
        }
    }
}
