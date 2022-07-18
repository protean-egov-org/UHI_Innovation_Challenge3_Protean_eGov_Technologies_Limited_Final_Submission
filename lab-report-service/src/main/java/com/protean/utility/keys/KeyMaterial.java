package com.protean.utility.keys;

import lombok.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class KeyMaterial {
    private String privateKey;
    private String publicKey;
    private String nonce;
}
