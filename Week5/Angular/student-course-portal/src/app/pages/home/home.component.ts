import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CourseService } from '../../services/course.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [FormsModule],
  template: `
    <h1>{{ portalName }}</h1>
    <p>Welcome to the portal.</p>
    <p>Courses Available: {{ available }} | Enrolled: 3 | GPA: 3.8</p>
    <button [disabled]="!isPortalActive" (click)="onEnrollClick()">Enroll Now</button>
    <p>{{ message }}</p>
    <input [(ngModel)]="searchTerm" placeholder="Search..." />
    <p>Searching for: {{ searchTerm }}</p>
  `
})
export class HomeComponent implements OnInit, OnDestroy {
  portalName = 'Student Course Portal';
  isPortalActive = true;
  message = '';
  searchTerm = '';
  available = 0;
  constructor(private courseService: CourseService) {}
  ngOnInit() {
    console.log('HomeComponent initialised — courses loaded');
    // Using service length as requested in intermediate task
    this.courseService.getCourses().subscribe(c => this.available = c.length);
  }
  ngOnDestroy() { console.log('HomeComponent destroyed'); }
  onEnrollClick() { this.message = 'Enrollment opened!'; }
}
