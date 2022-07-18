package com.protean.symptoms.utility;

import org.springframework.stereotype.Component;

import com.protean.symptoms.dto.MainRequestDTO;
import com.protean.symptoms.dto.MainResponseDTO;

@Component
public class AuthUtil {

	
	public static MainResponseDTO<?> getMainResponseDto(MainRequestDTO<?> mainRequestDto) {
		MainResponseDTO<?> response = new MainResponseDTO<>();
		if (mainRequestDto.getRequest() == null) {
			return response;
		}
		response.setId(mainRequestDto.getId());
		response.setVersion(mainRequestDto.getVersion());
		return response;
	}

}
