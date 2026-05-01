package com.optihire.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "jobs")
public class Job {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String title;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Enumerated(EnumType.STRING)
    private JobStatus status;
    
    @Column(columnDefinition = "TEXT")
    private String requirements;
    
    private String location;
    private String salary;
    
    private Long createdBy;
    private LocalDateTime createdAt = LocalDateTime.now();
}
