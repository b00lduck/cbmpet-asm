package com.b00lduck.pet.image_converter;

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

	public static void main(String[] args) throws IOException {

		ImageConverter imageConverter = new ImageConverter();
	    
		byte[] bytes = imageConverter.readBinaryFile("D:\\PET\\data\\b00lduck.raw");
			    
	    // Special RL encoding
	    //
	    // number of 0s 
	    // number of 1s
	    // number of 0s etc.
	    
	    List<Integer> output = new ArrayList<>();
	    
	    Integer currentCount = 0;
	    byte currentSubject = 0; // 0 or 1
	    
	    for(byte b : bytes) {
	    	
	    	if ((b == currentSubject) && (currentCount < 255)) {	    		
	    		currentCount++;	    		
	    	} else {
	    			    		
	    		if (currentSubject == 0) {
	    			currentSubject = 1;
	    		} else {
	    			currentSubject = 0;
	    		}
	    		
	    		output.add(currentCount);
	    		currentCount = 0;
	    	}
	    	
	    }
	    
	    byte[] out = new byte[output.size()];
	    int i = 0;
	    
	    for (Integer x : output) {
	    	
	    	out[i] = x.byteValue();
	    	i++;
	    }
	    
	    imageConverter.writeSmallBinaryFile(out, "D:\\PET\\data\\b00lduck.rle");		
		
		//byte[] x = readBinaryFile("D:\\PET\\data\\b00lduck.raw");

		
		
		
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
