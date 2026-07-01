package com.example.EmployeeManagementSystem.projection;

import org.springframework.beans.factory.annotation.Value;

public interface EmployeeProjection {

    @Value("#{target.name + ' ' + target.email}")
    String getFullName();
    
    String getName();
    String getEmail();
}
