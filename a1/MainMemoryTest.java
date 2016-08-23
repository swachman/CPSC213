package arch.sm213.machine.student;

import machine.AbstractMainMemory;

import static org.junit.Assert.*;

/**
 * Created by tongerin on 16/7/12.
 */
public class MainMemoryTest {

    MainMemory testMem;

    @org.junit.Before
    public void setUp(){
        testMem= new MainMemory(128);
    }

    @org.junit.Test
    public void testIsAccessAligned(){

        assertTrue(testMem.isAccessAligned(0,4)); //test the start point
        assertTrue(testMem.isAccessAligned(16,4)); //test the middle point
        assertFalse(testMem.isAccessAligned(1,8)); // test a small address, and change the length to test if
        assertFalse(testMem.isAccessAligned(63,32)); //try a big number
    }

    @org.junit.Test
    public void testBytesToInteger(){
        assertEquals(testMem.bytesToInteger((byte)0,(byte)0,(byte)0,(byte)0), 0);// test the simplest
        assertEquals(testMem.bytesToInteger((byte)0,(byte)4,(byte)5,(byte)8), 0x40508); // test a positive number
        assertEquals(testMem.bytesToInteger((byte)0,(byte)0,(byte)0x13,(byte)6),0x1306);// test a negative number
    }
    // test zero the simplest case
    @org.junit.Test
    public void testIntegerToBytesZero(){
        byte[] b= testMem.integerToBytes(0);
        assertEquals(b[0], (byte) 0);
        assertEquals(b[1], (byte) 0);
        assertEquals(b[2], (byte) 0);
        assertEquals(b[3], (byte) 0);
    }
    //test a positive integer
    @org.junit.Test
    public void testIntegerToBytesPositive(){
        byte[] b= testMem.integerToBytes(111);
        assertEquals(b[0], (byte) 0);
        assertEquals(b[1], (byte) 0);
        assertEquals(b[2], (byte) 0);
        assertEquals(b[3], (byte) 0x6f);
    }
    // test a negative integer
    @org.junit.Test
    public void testIntegerToBytesNegative(){
        byte[] b= testMem.integerToBytes(-678);
        assertEquals(b[0], (byte) 0xff);
        assertEquals(b[1], (byte) 0xff);
        assertEquals(b[2], (byte) 0xfd);
        assertEquals(b[3], (byte) 0x5a);
    }
    // test the set and get when byte[] is 00000000(no exception throws)
    @org.junit.Test
    public void testGetAndSetMemToZero() throws AbstractMainMemory.InvalidAddressException {
        byte[] value = setValueZero();
        testMem.set(0,value);
        byte[] actual= testMem.get(0,4);
        assertEquals(value[0],actual[0]);
        assertEquals(value[1],actual[1]);
        assertEquals(value[2],actual[2]);
        assertEquals(value[3],actual[3]);
    }

    // test the set and get when byte[] is 00000000(no exception throws)
    @org.junit.Test
    public void testGetAndSetMemToValidNum() throws AbstractMainMemory.InvalidAddressException {
        byte[] value = setVaildArray();
        testMem.set(10,value);
        byte[] actual = testMem.get(10,4);
        assertEquals(value[0], actual[0]);
        assertEquals(value[1],actual[1]);
        assertEquals(value[2],actual[2]);
        assertEquals(value[3],actual[3]);
    }
    // test a random valid input
    @org.junit.Test
    public void testSetAndGetInvalidSetter() throws AbstractMainMemory.InvalidAddressException {
        byte[] value = setVaildArray();
        try {
            testMem.set(250, value);
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("InvalidAddressException catched!");
        }
    }

    @org.junit.Test
    public void testSetAndGetInvalidGetter() throws AbstractMainMemory.InvalidAddressException {
        byte[] value = setVaildArray();
        testMem.set(0,value);
        try {
            testMem.get(250, 4);
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("InvalidAddressException catched!");
        }

    }


    private byte[] setValueZero(){
        byte[] b1= new byte[4];
        b1[0]= (byte) (0x00);
        b1[1]= (byte) (0x00);
        b1[2]= (byte) (0x00);
        b1[3]= (byte) (0x00);
        return b1;
    }
    private byte[] setVaildArray(){
        byte[] b2= new byte[4];
        b2[0] =(byte) (0x14);
        b2[1] =(byte) (0x06);
        b2[2] =(byte) (0x0b);
        b2[3] =(byte) (0x01);
        return b2;
    }

}