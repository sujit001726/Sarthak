package com.optihire.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "interviews")
public class Interview {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "application_id")
    private Application application;
    
    private LocalDateTime scheduledDate;
    
    private String interviewer;
    
    private String status; // SCHEDULED, COMPLETED, CANCELLED
    
    @Column(columnDefinition = "TEXT")
    private String feedback;
}
