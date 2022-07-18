package com.protean.utility.encrypt;

import lombok.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class EncryptionResponse {
    private String encryptedData;
    private String keyToShare;
}
