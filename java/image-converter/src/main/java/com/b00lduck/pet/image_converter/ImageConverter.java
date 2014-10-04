package com.b00lduck.pet.image_converter;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

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
		
		
		imageConverter.createBittable("D:\\PET\\asm\\data_bitmap_font_table.asm");
		
		//imageConverter.convert("D:\\PET\\data\\b00lduck.raw", "D:\\PET\\data\\b00lduck.rle");
		imageConverter.convertNa("D:\\PET\\data\\b00lduck.raw", "D:\\PET\\data\\b00lduck.nar");
		
		imageConverter.convertNa("D:\\PET\\data\\font.raw", "D:\\PET\\data\\font1.nar");
		
	}
	
	private static final SortedMap<String, Object> mapMap = new TreeMap<>();
	
	static {
		
		mapMap.put("pixel_move_lut_s0_t1_a", new int[] { 0, 1, 0, 3, 2, 5, 4, 7 });	
		mapMap.put("pixel_move_lut_s0_t1_b", new int[] { 6, 0, 8, 0, 0, 0, 0, 0 });
		
		mapMap.put("pixel_move_lut_s0_t2_a", new int[] { 0, 0, 0, 0, 1, 2, 3, 4 });
		mapMap.put("pixel_move_lut_s0_t2_b", new int[] { 5, 6, 7, 8, 0, 0, 0, 0 });		

		mapMap.put("pixel_move_lut_s0_t3_a", new int[] { 0, 0, 0, 0, 0, 1, 0, 3 });
		mapMap.put("pixel_move_lut_s0_t3_b", new int[] { 2, 5, 4, 7, 6, 0, 8, 0 });		
				
		mapMap.put("pixel_move_lut_s1_t0_a", "pixel_move_lut_s0_t3_b");
		mapMap.put("pixel_move_lut_s1_t0_b", "pixel_move_lut_s0_t3_a");
		
		mapMap.put("pixel_move_lut_s1_t2_a", new int[] { 0, 0, 0, 0, 2, 5, 4, 7 });
		
		mapMap.put("pixel_move_lut_s1_t2_b", "pixel_move_lut_s0_t1_b");
		mapMap.put("pixel_move_lut_s1_t2_c", new int[] { 0, 1, 0, 3, 0, 0, 0, 0 });
		
		mapMap.put("pixel_move_lut_s1_t3_a", new int[] { 0, 0, 0, 0, 0, 2, 0, 4 });
		mapMap.put("pixel_move_lut_s1_t3_b", "pixel_move_lut_s0_t2_b");
		mapMap.put("pixel_move_lut_s1_t3_c", new int[] { 0, 0, 0, 0, 1, 0, 3, 0 });
				
		mapMap.put("pixel_move_lut_s2_t0_a", "pixel_move_lut_s0_t2_b");
		mapMap.put("pixel_move_lut_s2_t0_b", "pixel_move_lut_s0_t2_a");

		
		mapMap.put("pixel_move_lut_s2_t1_a", new int[] { 0, 5, 0, 7, 6, 0, 8, 0 });
		mapMap.put("pixel_move_lut_s2_t1_b", "pixel_move_lut_s0_t3_a");
		mapMap.put("pixel_move_lut_s2_t1_c", new int[] { 2, 0, 4, 0, 0, 0, 0, 0 });
		
				
		mapMap.put("pixel_move_lut_s2_t3_a", new int[] { 0, 0, 0, 0, 0, 5, 0, 7 });
		mapMap.put("pixel_move_lut_s2_t3_b", "pixel_move_lut_s0_t1_b");
		mapMap.put("pixel_move_lut_s2_t3_c", new int[] { 0, 1, 0, 3, 2, 0, 4, 0 });		
		
		mapMap.put("pixel_move_lut_s3_t0_a", "pixel_move_lut_s0_t1_b");
		mapMap.put("pixel_move_lut_s3_t0_b", "pixel_move_lut_s0_t1_a");							
			
		mapMap.put("pixel_move_lut_s3_t1_a", new int[] { 0, 6, 0, 8, 0, 0, 0, 0 });
		mapMap.put("pixel_move_lut_s3_t1_b", "pixel_move_lut_s0_t2_a");
		mapMap.put("pixel_move_lut_s3_t1_c", new int[] { 5, 0, 7, 0, 0, 0, 0, 0 });

		mapMap.put("pixel_move_lut_s3_t2_a", new int[] { 0, 0, 0, 0, 6, 0, 8, 0 });
		mapMap.put("pixel_move_lut_s3_t2_b", "pixel_move_lut_s0_t3_a");
		mapMap.put("pixel_move_lut_s3_t2_c", new int[] { 2, 5, 4, 7, 0, 0, 0, 0 });		
		
	}
	
	
	public void createBittable(final String dest) throws IOException {		
	    FileOutputStream fos = new FileOutputStream(dest);	            
	    fos.write(bittable().getBytes());	    	   
	    fos.close();						
	}
	
	
	public String bittable() {
		
		String ret = "// THIS FILE IS GENERATED - DO NOT CHANGE!\n.pc = DBMF_TABLES \"Lookup tables (aligned)\"\n"; 
		ret += ".align $0100\n";		
		ret += "// Conversion table for bitmap font output\n";
		
		for (Map.Entry<String, Object> entry : mapMap.entrySet()) {
			
			if (entry.getValue() instanceof int[]) {
				
				int[] arrayEntry = ((int[])entry.getValue()); 
			
				ret += entry.getKey() + ":\n";
				
				// check if this map has any copies
				for (Map.Entry<String, Object> copyEntry : mapMap.entrySet()) {
					
					if (copyEntry.getValue() instanceof String) {
						
						if(copyEntry.getValue().equals(entry.getKey())) {
							
							ret += copyEntry.getKey() + ":\n";
							
						}
						
					}
					
				}
				
				ret += ".byte ";
				
				
				
				for(int i=0; i<256; i++) {
					
					String s = String.format("%8s", Integer.toBinaryString(i).toUpperCase()).replace(' ', '0');
					
					//System.out.print(s + " ");
					
					Integer out = 0;
					for(int targetBitNum=0;targetBitNum<8;targetBitNum++) {
									
						// get src bit number from array
						int srcBitNum = arrayEntry[targetBitNum];
						
						if (srcBitNum > 0) {
							
							srcBitNum--; // LSB=Bit 7 / MSB=Bit 0 
							
							// 	get the source bit state
							int srcvalue = s.charAt(srcBitNum) == '1' ? 1 : 0;
						
							out += srcvalue << (7-targetBitNum); // LSB=Bit 7 / MSB=Bit 0 
						}
					}
					
					//System.out.println(String.format("%8s", Integer.toBinaryString(out).toUpperCase()).replace(' ', '0'));
					
					ret += String.format("$%2s", Integer.toHexString(out).toUpperCase()).replace(' ', '0');
					
					if(i < 255) {
						ret += ",";
					} else {
						ret += "\n";
					}
					
				}
				
			}
			
		}
		
		return ret;
		
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
