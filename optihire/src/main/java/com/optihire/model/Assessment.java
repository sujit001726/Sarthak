package com.optihire.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "assessments")
public class Assessment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "candidate_id")
    private Candidate candidate;
    
    @ManyToOne
    @JoinColumn(name = "quiz_id")
    private Quiz quiz;
    
    private Double score;
    
    private LocalDateTime completedAt;
}
