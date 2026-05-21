using System.Buffers.Binary;
using System.Text;

namespace MeteorReborn.Launcher;

internal sealed class BlowfishCipher
{
    private const int N = 16;

    private readonly uint[] _p = new uint[N + 2];
    private readonly uint[] _s = new uint[4 * 256];

    private static readonly uint[] PInit;
    private static readonly uint[] SInit;

    static BlowfishCipher()
    {
        var pBytes = Convert.FromBase64String(
            "iGo/JNMIo4UuihkTRHNwAyI4CaTQMZ8pmPouCIlsTuzmIShFdxPQOM9mVL5sDOk0tymswN1QfMm11YQ/FwlHtdnVFpIb+3mJ");
        var sBytes = Convert.FromBase64String(
            "pgsx0ay135jbcv0vt98a0O2v4biWfiZqRZB8upl/LPFHmaEk92yRs+LyAQgW/I6F2CBpY2lOV3Gj/likfj2T9I90lQ1Yto5y" +
            "WM2Lce5KFYIdpFR7tVlawjnVMJwTYPIqI7DRxfCFYCgYeUHK7zjbuLDceY4OGDpgiw6ebD6KHrDBdxXXJ0sxvdovr3hgXGBV" +
            "8yVV5pSrVapimEhXQBToY2o5ylW2EKsqNFzMtM7oQRGvhlShk+lyfBEU7rMqvG9jXcWpK/YxGHQWPlzOHpOHmzO61q9czyRs" +
            "gVMyeneGlSiYSI87r7lLaxvov8STIShmzAnYYZGpIftgrHxIMoDsXV1dhO+xdYXpAiMm3IgbZeuBPokjxayW0/NvbQ85QvSDgk" +
            "QLLgQghKRK8MhpXpsfnkJoxiGabOn2YZwMZ/CI06vSoFFqaC9U2CinD5ajM1GrbAvvbuQ7ehNQ8Du6mCr7fh1l8aF2Aa85Pl" +
            "nKZogOQ4IZhu6MtJ9vRcOlhH2+Xos72HVv4HMgwYWfRBpApmrBVmKq004Gdz82ct/+Gz0Cm0Ik19A3SBIK0NPqD9ubwPFJyX" +
            "JTB3sbmYDYedQl997o9hpQ/uM7THm2veBsl7oGwAS2T6nBxGCfQMKeXF5jJGoZr2/7aLVTbD7rsjkTb+xSOx9R/G0slTCbRE" +
            "WBzAm9Xq8E0OO+/Uoz3gcoD2azSy4ZV6jLwA90yEU5XwvS2/vTub3AeVUKMmAaxgCh1nlyLED+JZ9nzKMf+/jppY74IjLb3x" +
            "Z1PBVrYf3IHlAvq1IFrfq1PTJghyP9SHsxU4LfAD67V1yeoIxvyi5WhxrbaRff9qhC1cP/fijGMmesc1VPjLAnW2nIWMq7XaP" +
            "/4aAR8LiYPfoQuIMh/Wy1/Epb09EteeRTmmVF+La8SY7SkJf7S9ry3eEzfsukQRP7YujG5M7ayiDvAUx3Nv6eftC0H/ErTdr" +
            "blZiRkK5xjq3qoNWTa9DRjtDgJcevL1s8jreUdY774vaPZCsS8hK4iIgc8A2QoF6tTxzDj2iR8c/RrcGosxgiLy93Fw6+/i1" +
            "16qEfAosPzKDl6HRvtdbzrBiZ4onO4E+otLfgE/2BO8R82ait0maiXxYFd5WAFHPMk3cUGiFlIK3mhvq1d/VCVMfPNZ37DK/N" +
            "66CJPnvTG0HWSX4eri0OJQBes3EguwBoIq/guFebNmQkHrkJ8B2RY1Wqpt9ZiUPBeH9TWtmiW30gxbnlAnYDJoOpz5ViaBnIE" +
            "UFKc07KLUezSqkUe1IAURsVKVOaP1cP1uTGm7x2pGArAHTmgbVvuggf6RtXa+yW8hXZDSohZWO2tvm55y4FNP9kVoXFXS2wU" +
            "6GPn6mZR7oIageFbulwektEKbO1Lgl12yMmGcSwpm6tfd+nSbhg7pxmsu2PcYyq7P8XmmlsUmRW4Z6xwqUCNhkpTAl1QBNZoD" +
            "46GOSamFQ/ZZ1CW9bkj2vWP/eZB5zSofUw6O/mOC1NwV0l8IYg3Uwm63CExumCY17MHgI/a2gJye+6PhQYlzyhcGprhDV/aI" +
            "bioFIFU5y3NwdQqhyEBz5crt5/7ER9jrjyFlc32jqwDQxQ8AQfHPD/swACGvUMrrJ0tTxYeoMlvSEJ3PkTkdH2L6l8c0cylA" +
            "FH9SKB5eU63NrCNzR2tcin3fOaRmFEqQ4D0A8+x8jsQR51pJnNOOIvDuo7obuAMjGzPhg4i1ROCLltTwMNQm+/BAr2kBK4LH" +
            "l8lyRysHlWr4mvvB93mt4QCJPZEq6Lsy4/z9wfchJVJHFrLubdGlCHzYSfGEdYehfaCHS8mp+8jH1L6Trseuz6HYXbZkMJY9" +
            "LDZMRHGBzvCNkVMjc7Q90WusIkQ02hElHEZSoCAJRQ3eQ6E57433FVTjEQ1nesgZsZEV/xVjUEa8ej1zsYETwJpSRZ7eaP8v" +
            "r78Zcsv7qebjwVHnBF44axb+nqCl4OhrMqPloc5x93+gY9TrncZSkPHeeZ1ok+gCXIZlJ4yUwuarMQnLoOFcZ46uKUUzz8pf" +
            "QtCh6nTvfyPSsdNg8mORlgecIZCKcjUrYSE/du/q3rZh/D6pVFvOODyHum0Td/sSj/jAHv3TLDpVpsvoUhWGUCmKtoD6XO7j" +
            "uVL9utfe8qhC9uWyi2IRVwYQcpdUfd7BAVn2EwqMwTlr1h6x7+NAPPYwOqkFxztTmicEwLnp7VFN6qy7yGzO6nLGJgq1yrn" +
            "G6E87KvHotkyvC9GblpI6BQu1plMlpoQLO0KjzV6Z4x97ghwBkLVJuZoF+Hfpn3lah9PWKaiDf4dy3jl1+T7RGBEmgWKYg1D" +
            "tYf5seh396WmbpYeKWE9VdjciIb/8ODm5ZGwhrrCrPNVDAuU+RI2Y8oMbxt7/LrWOr/xjRh7Sj+czx87tkUSl3jt2ToFF0QQu" +
            "ATPiC24u5F6quqoxVPbNvQT8v6QvRCx7W7au8dO09lBSHNQZ55HtjHTYWGakdL5FBigT3yoWLPRiaNW6CDiPyjtsfBwyQVf5J" +
            "0y2kLioRHhbKSVgC/WwmdSBmtdLFiFAAOgiMqjUJY6vVVDD70rR1hcD8jkvByM0F+k43x7F/W2zsibFk33nxgdO7Lp/KFQG4" +
            "yd86EgAemnlD4GVXY7+g1l9lhqqdpqcIGDMX8qwRa3MoLgC56RJ6ENEXDBWfV/cmeHg7T23PbzYhVEHnaX2dAQ2fjZTTExdg" +
            "4PnGe+Cg9IP9t8echPhVKPbCPK5/j5vetg9toWj3p90CBlBwmTPY0KWmU9yAVQffUAnYua/S8aACi1HEkCNRq9CAzt9S3Q69" +
            "hAFAu9jkeRkUkl3RPIRRAiIu/HfyVTa+RtZbT3fRwRS+gZuwJvL+Fl70D0G2sfwSFyzGzJ+uWQTn9VeZHJdqaCsqrJXhQKP" +
            "QpBFPahiwK+2226WIU3GgAaUjXpMAOaO6NoSei/j9PjK2H6AbgjLW21vR6fB7OquxfN9OZo3jOQiprQDWe/iC5hfPZq9c57o" +
            "tOEjv3+skdVhhtSzFmoyayl+PqdPpuOjJDW93350Fo+yB4yk71CvuXs/7YrFZARSeVSLo6OlNVh42DILepa/5LlZbQvGeoVV" +
            "iaFaFjKanMM9vhmVZKKqb5JTE/HH70XnwxKZAC6Pj9cC8nBFwVu4DjLCgFSBXBlSJtxuQ/E8FI3IYPx+7J+QcPHwRBpHlHQB" +
            "duiF3rUV8y0cCb1Y/BvPJkNRFBNHh7JWCcKmCj6PjfG2xjH8K0Eg6eMuEC0U9mrxWB0crglSNr4ZI+M2ILJDsiub7uDqKyh" +
            "ZkNuuaMDHLeKPeiLUV4EtD9lLeVYgh9ZPD1zOdvo0lU+kh9hyf9ncMejT7zQWNHCnT/Lpmrbm86N/349GDcEqj43euhTOEbmQ" +
            "1rbtsQVXvGNyxnbTvUZScE6NDcxw0p8aP/AMySDzm1C+0Pafufe2acfdvOC8+RoKNeFdmILxO7JK1bUb95lHvr1jt2sy45N3" +
            "lZEcyX4iaALTEu9KetQmg7K2rGzEx1EhzxLng3QhJq51GSt+a7oQZQY/tLGBBrGvrtyhHYvSU9ycPh4lkWQkSGExIKbuwM2S" +
            "rqq9VOZ69kX6iG2ojpv77+w+RkV4C8nYbA9/D4e3hgTWADYEaD/dGwHzj2BK5Fd8z8Ntcza0KDcase8IdBgLBfXgA8vlegdyS" +
            "u6L2ZQkZVYS5Yv4/0WE6i/d3yOO909MK9iYfD+WZTdI6zyFXydbS52fxGYSbreoTfHYt5DmqE4pVfkY5ZbkZwV7QgkVXVjE" +
            "zeAsnhrAu50AWCu0hiqBGeqXR1thl/twncqeChCS1mM0YyxAIfWuiMvvAJJaCZShD+bh0dPbka36SlCw/yhqFp8Wgog9q33P4" +
            "GOVebzuKhUn/NTwFeEVD6gwanxLUCoCfQ5g0njPiaQYY/dwZMYMO1BqhhKHoX8OCG9cCqWGAAYn3cMNee5hFj6jgjlN3CUzQ" +
            "WwsJW7su73ra8kKF9/Ot2HVnOCeQFb4gBfEs9CnI5JHySfF9y44a5nU1ytFvBGvy4ntN4VVTttaX8CNN8PdjED61NXu9QHvjm" +
            "YbHZFIWiPBNRbOfH1W/ETuFWzr8qNjfIxt00MprXEoJjko76DmfgAGBAN845Os/1+tM3d8KrGy3FWp5nsFxCN6NPQCeC076bv" +
            "JmdjhHVFXMPv34cLdZ7xADHaxuMt0WQoSG+sW6ytG42ai+rSFd5bpS80najxsjCSWXu+A9Tfd6NRh0Kc9XGTdBM27s5KVBGu" +
            "qnoJpWsBONevvDV+qGaUS1q4ozvYyLuhpq4wonA9i4kQ6oDHqWk0PKcumHAg01q6ZtQFeWP1ltkuvmiJijhOjqnhpWpS+liV" +
            "e/T7y/H2vdS92lvBD9ZCvp3FankgAGGsIet5gmbk+U+O1r9kOmX1zSe2bfwLFGLKwI6rNWWfaZ9AdY+z9EoLX18zyWfH5u48" +
            "q1ytNZaTPWIWnGsKeDmpRng/aywR5v6k+2NxNPozFc7KClm1fgoLhN5kQFfeFVgde1EDpb3jF7T49RtBRW6bfSIJWGhA73wZ" +
            "AUVnuvDoleQPOwaJ5cqBzqpm20/G/UhYx77Zpz1GfPcJijZM3X1/VWxgjRWA7s8uooRd1Eo+NkKwmdRzKtfkq3MURfoTY7cM" +
            "DhiWJ03kfkgk8KQeurOez77ZM4hUTK+T3d+47aoRj0pw2lT3kiA5hNkEAiuoiSybd39LYVpZiEHCQpGmrPdwEVkz95sWK7II" +
            "Bzd975bQI1YG38B0sy747Rrfmqi3UX/WTpECjU+1c20vKjO6nK7hGT6rhJmjUdvPL9j5JvSnl0vVBt3wq5wY072jQ0OdFcTW" +
            "+dxFnL4XX1TrwjLQEDM4rROakbSNISvFQEoBLDhHTqYlbSfuAZIoG7Ogjs/b4KrIDVLHRoB+CdyJ7FgFWHcP5PnK3k6u70lR" +
            "TThOYigS3nOUbfJMi/Juh+gfsgc4PbRx7zDEQHPx6rooUmHkBqavU/Uy97a0DjaCtUqwzkDZzaRxnwx+Y1PK7Hgt1me9zq79" +
            "UP/GdXynEXZJywil78q/OYVcfyRDyUVlJthk+X665y2zllkqMLRqLoSXgfBtgxqBeNlUNIQQqQDyw5u7OA725gWvqCYTGTpe" +
            "DIylR+f35LT4Cs0oNMe8nGJQXQKG4w0o0sgcb7F2DJ2w42fNd8uL5mbR28L5h3x4w9U2kzlkdjaHs95Ys5vfj7NZrEYFgUdL" +
            "P3F0o+EmSL79lfzI/UjdjKmMTWokwLNzFZigfCstet1Wpc2Fm7Mc9KIkmKW3tBJuYEbkFBMFFbGcb3HxuYKFHoyBtDhRZp78" +
            "sP9U6rJAA+oYuK/Jbv20r01BWkScSICBLJ8z8u2K5x2zcA+EVPT40AWYL2rOPCtRyWcIDi6ds5G98Whr3dgYHUgTv7LhdiN6" +
            "Iqw+ap6fqr5TFzCSBmMivsC5GrDAfnh69Zp+NSQoN5cpi0lCT+f5gjCMmFOt1vid87j349X5nLDOg==");

        PInit = new uint[N + 2];
        Buffer.BlockCopy(pBytes, 0, PInit, 0, pBytes.Length);

        SInit = new uint[4 * 256];
        Buffer.BlockCopy(sBytes, 0, SInit, 0, sBytes.Length);
    }

    public void Initialize(byte[] key, int keyLength)
    {
        Array.Copy(PInit, _p, PInit.Length);
        Array.Copy(SInit, _s, SInit.Length);

        int j = 0;
        for (int i = 0; i < N + 2; i++)
        {
            uint data = 0;
            for (int k = 0; k < 4; k++)
            {
                data = (data << 8) | key[j];
                j++;
                if (j >= keyLength) j = 0;
            }
            _p[i] ^= data;
        }

        uint datal = 0, datar = 0;
        for (int i = 0; i < N + 2; i += 2)
        {
            Encipher(ref datal, ref datar);
            _p[i] = datal;
            _p[i + 1] = datar;
        }

        for (int i = 0; i < 4; i++)
        {
            for (j = 0; j < 256; j += 2)
            {
                Encipher(ref datal, ref datar);
                _s[i * 256 + j] = datal;
                _s[i * 256 + j + 1] = datar;
            }
        }
    }

    private uint F(uint x)
    {
        ushort a = (ushort)((x >> 24) & 0xFF);
        ushort b = (ushort)((x >> 16) & 0xFF);
        ushort c = (ushort)((x >> 8) & 0xFF);
        ushort d = (ushort)(x & 0xFF);

        uint y = _s[a] + _s[256 + b];
        y ^= _s[512 + c];
        y += _s[768 + d];
        return y;
    }

    public void Encipher(ref uint xl, ref uint xr)
    {
        for (int i = 0; i < N; i++)
        {
            xl ^= _p[i];
            xr = F(xl) ^ xr;
            (xl, xr) = (xr, xl);
        }
        (xl, xr) = (xr, xl);
        xr ^= _p[N];
        xl ^= _p[N + 1];
    }

    public void EncryptInPlace(byte[] data, int length)
    {
        int aligned = length & ~0x7;
        for (int i = 0; i < aligned; i += 8)
        {
            uint xl = BinaryPrimitives.ReadUInt32LittleEndian(data.AsSpan(i));
            uint xr = BinaryPrimitives.ReadUInt32LittleEndian(data.AsSpan(i + 4));
            Encipher(ref xl, ref xr);
            BinaryPrimitives.WriteUInt32LittleEndian(data.AsSpan(i), xl);
            BinaryPrimitives.WriteUInt32LittleEndian(data.AsSpan(i + 4), xr);
        }
    }
}
