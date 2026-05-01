package com.optihire.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "applications")
public class Application {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "job_id")
    private Job job;
    
    @ManyToOne
    @JoinColumn(name = "candidate_id")
    private Candidate candidate;
    
    @Enumerated(EnumType.STRING)
    private ApplicationStatus status;
    
    private LocalDateTime appliedDate = LocalDateTime.now();
    
    @Column(columnDefinition = "TEXT")
    private String notes;
}
