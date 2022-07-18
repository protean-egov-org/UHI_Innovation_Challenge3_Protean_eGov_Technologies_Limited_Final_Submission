package com.protean.utility.encrypt;

import lombok.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class EncryptionRequest {
    private String receiverPublicKey;
    private String receiverNonce;
    private String senderPrivateKey;

    private String senderPublicKey;
    private String senderNonce;
    private String plainTextData;
}
