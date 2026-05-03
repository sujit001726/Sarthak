package com.optihire.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "quizzes")
public class Quiz {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String title;
    
    @Column(columnDefinition = "JSON")
    private String questions;
    
    private String type;
    
    private LocalDateTime createdAt = LocalDateTime.now();
}
