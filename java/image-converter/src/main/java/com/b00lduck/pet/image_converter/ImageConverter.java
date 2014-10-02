package com.b00lduck.pet.image_converter;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Image Converter
 * 
 */
public class ImageConverter {
	
	byte currentSubject = 0;
	Integer currentCount = 0;
	
	private static Integer MAX = 254;

	public static void main(String[] args) throws IOException {

		ImageConverter imageConverter = new ImageConverter();
		
		imageConverter.bittable();
		
		//imageConverter.convert("D:\\PET\\data\\b00lduck.raw", "D:\\PET\\data\\b00lduck.rle");
		//imageConverter.convertNa("D:\\PET\\data\\b00lduck.raw", "D:\\PET\\data\\b00lduck.nar");
		
		//imageConverter.convertNa("D:\\PET\\data\\font.raw", "D:\\PET\\data\\font1.nar");
		
	}
	
	public void bittable() {

		//int mapping1[] = { 0, 1, 0, 3, 2, 5, 4, 7 }; // Even source, odd target: target byte 1 
		//int mapping1[] = { 6, 0, 8, 0, 0, 0, 0, 0 }; // Even source, odd target: target byte 2
		
		//int mapping1[] = { 2, 5, 4, 7, 6, 0, 8, 0 }; // Odd source, even target: source byte 1
		int mapping1[] = { 0, 0, 0, 0, 0, 1, 0, 3 }; // Odd source, even target: source byte 2
		
		
		for(Integer i=0;i<256;i++) {
			
			String s = String.format("%8s", Integer.toBinaryString(i).toUpperCase()).replace(' ', '0');
			
			Integer out = 0;
			
			for(int x=0;x<8;x++) {
							
				int srcvalue = s.charAt(x) == '1' ? 1 : 0;
				
				int map  = mapping1[7 - x];
				
				if (map > 0) {
					out += srcvalue << (map - 1);	
				}
				
			}

			String outstring = String.format("%8s", Integer.toBinaryString(out).toUpperCase()).replace(' ', '0');
			
			// System.out.println(s + " " + outstring);
			
			String outstring1 = String.format("$%2s", Integer.toHexString(out).toUpperCase()).replace(' ', '0');
			System.out.print(outstring1 + ",");
			
		}
		
	}
	
	public void convertNa(String src, String dest) throws IOException {
		
		byte[] bytes = readBinaryFile(src);
			    
	    // raw encoding
		//
		//
		// SRC                                        DEST
		// 0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01 => 0xff
		// 0x00,0x00,0x00,0x00,0x01,0x01,0x01,0x01 => 0x0f
					    	    	        	   
	    FileOutputStream fos = new FileOutputStream(dest);	 		
		
	    for(int y = 0; y < 16; y++) {
	    	
	    	for(int x = 0; x < 20; x++) {
	    	
	    		char out = 0;
	    		
	    		int src_ofs = (x*4) + y* 160;
	    		
	    		out += getByte(bytes, src_ofs) << 7;
	    		out += getByte(bytes, src_ofs+1) << 6;
	    		out += getByte(bytes, src_ofs+80) << 5;
	    		out += getByte(bytes, src_ofs+81) << 4;
	    		
	    		src_ofs += 2;
	    		
	    		out += getByte(bytes, src_ofs) << 3;
	    		out += getByte(bytes, src_ofs+1) << 2;
	    		out += getByte(bytes, src_ofs+80) << 1;
	    		out += getByte(bytes, src_ofs+81);
	    		
	    		fos.write(out);
	    		    	
	    	}
	    }
	    
	    fos.close();	    	
		
	}	
	
	private byte getByte(byte[] bytes, int offset) {
		byte ret = bytes[offset];
		if (ret != 0) return 1;
		return 0;
	}
	
	
	public void convert(String src, String dest) throws IOException {
		
		byte[] bytes = readBinaryFile(src);
			    
	    // Special RL encoding
	    //
	    // number of 0s 
	    // number of 1s
	    // number of 0s etc.
	    
	    List<Integer> output = new ArrayList<>();
	    	        	    
	    for(int i = 0; i < bytes.length; i++) {
	    	
	    	if (bytes[i] == currentSubject) {	    		
	    		
	    		currentCount++;	    		
	    	
	    	} else {
	    		
	    		i--;
	    		
	    		while (currentCount > MAX) {
	    			
	    			System.out.println(currentSubject + ":" + String.format("0x%2s", Integer.toHexString(MAX).toUpperCase()).replace(' ', '0'));
	    			output.add(MAX);

	    			System.out.println(flippedCurrentSubject(currentSubject) + ":" + String.format("0x%2s", Integer.toHexString(0).toUpperCase()).replace(' ', '0'));
	    			output.add(0);
	    			
	    			currentCount -= MAX;	    			
	    			
	    		}

	    		System.out.println(currentSubject + ":" + String.format("0x%2s", Integer.toHexString(currentCount).toUpperCase()).replace(' ', '0'));
		    	output.add(currentCount);
		    	
		    	currentCount = 0;
	    		
		    	currentSubject = flippedCurrentSubject(currentSubject);
		    	
				    	
		    				    			    		
	    	}
	    	
	    }
	    
	    FileOutputStream fos = new FileOutputStream(dest);	    
	        
	    for (Integer x : output) {	    
	    	
	    	byte i = (byte) (x & 0xff);
	    	
	    	fos.write(i);
	    }
	    fos.close();
	    
	
		
	}
	
	private byte flippedCurrentSubject(byte cs) {
		if (cs == 0) {
			return 1;
		} else {
			return 0;
		}		
	}
	
	private byte[] readBinaryFile(final String filename)
			throws IOException {

		Path path = Paths.get(filename);
		return Files.readAllBytes(path);

	}

	
	private void writeSmallBinaryFile(byte[] aBytes, String aFileName)
			throws IOException {
		
		Path path = Paths.get(aFileName);
		Files.write(path, aBytes);
		
	}

}
