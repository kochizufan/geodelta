
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

    /* package */static int packSubDelta(final int level, final int id)
    {
        return id << (26 - ((level - 2) * 2));
    }

    /* package */static byte unpackSubDelta(final int level, final int value)
    {
        return (byte)((value >> (26 - ((level - 2) * 2))) & 0x03);
    }

    /* package */static int packLevel(final int level)
    {
        return level;
    }

    /* package */static int unpackLevel(final int value)
    {
        return value & 0x0F;
    }
}
