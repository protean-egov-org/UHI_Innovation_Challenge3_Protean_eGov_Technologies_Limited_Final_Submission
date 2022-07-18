package com.example.utility.decrypt;

import lombok.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class DecryptionRequest {

    private String receiverPrivateKey;
    private String receiverNonce;
    private String senderPublicKey;
    private String senderNonce;
    private String encryptedData;

}
