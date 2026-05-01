package com.optihire.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "candidates")
public class Candidate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    
    @Column(unique = true)
    private String email;
    private String phone;
    private String resume;
    
    @Enumerated(EnumType.STRING)
    private ExperienceLevel experienceLevel;
    
    private String status;
    private LocalDateTime appliedDate = LocalDateTime.now();
}
