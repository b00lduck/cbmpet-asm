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
	    
		imageConverter.convert("D:\\PET\\data\\b00lduck.raw", "D:\\PET\\data\\b00lduck.rle");
		imageConverter.convertNa("D:\\PET\\data\\b00lduck.raw", "D:\\PET\\data\\b00lduck.nar");
		
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
	    		
	    		out += bytes[src_ofs] << 7;
	    		out += bytes[src_ofs+1] << 6;
	    		out += bytes[src_ofs+80] << 5;
	    		out += bytes[src_ofs+81] << 4;
	    		
	    		src_ofs += 2;
	    		
	    		out += bytes[src_ofs] << 3;
	    		out += bytes[src_ofs+1] << 2;
	    		out += bytes[src_ofs+80] << 1;
	    		out += bytes[src_ofs+81];
	    		
	    		fos.write(out);
	    		    	
	    	}
	    }
	    
	    fos.close();	    	
		
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
