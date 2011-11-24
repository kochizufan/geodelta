
package jp.nayutaya.geodelta;

public class Packer32
{
    /* package */static int packWorldDelta(final int id)
    {
        return id << 28;
    }

    /* package */static byte unpackWorldDelta(final int value)
    {
        return (byte)((value >> 28) & 0x07);
    }
}
