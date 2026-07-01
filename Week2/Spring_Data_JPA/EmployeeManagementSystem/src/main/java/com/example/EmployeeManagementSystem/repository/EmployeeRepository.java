package com.example.EmployeeManagementSystem.repository;

import com.example.EmployeeManagementSystem.entity.Employee;
import com.example.EmployeeManagementSystem.projection.EmployeeProjection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    // Custom query method using keyword
    List<Employee> findByDepartmentId(Long departmentId);

    // Custom query method using @Query
    @Query("SELECT e FROM Employee e WHERE e.name LIKE %:name%")
    List<Employee> findByNameContaining(@Param("name") String name);

    // Named query defined in entity
    List<Employee> findByEmailNamed(@Param("email") String email);
    List<Employee> findByDepartmentIdNamed(@Param("deptId") Long deptId);

    // Pagination and sorting
    Page<Employee> findAll(Pageable pageable);

    // Projection
    @Query("SELECT e FROM Employee e")
    List<EmployeeProjection> findAllEmployeeProjections();
}
