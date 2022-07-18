package com.protean.entity;

import lombok.*;

import javax.persistence.*;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "hip_data_dtls")
public class HipDataEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String labname;
    @Column(columnDefinition = "TEXT")
    private String fhirString;
}
