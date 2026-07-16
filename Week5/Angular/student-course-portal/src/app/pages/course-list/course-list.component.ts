import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Store } from '@ngrx/store';
import { Course } from '../../models/course.model';
import { selectAllCourses } from '../../store/course.selectors';
import { loadCourses } from '../../store/course.actions';
import { CourseCardComponent } from '../../components/course-card/course-card.component';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-course-list',
  standalone: true,
  imports: [CommonModule, CourseCardComponent],
  template: `
    <p *ngIf="isLoading">Loading courses...</p>
    <div *ngIf="!isLoading">
      <div *ngIf="(courses$ | async)?.length === 0; else courseGrid">
        <p>No courses available.</p>
      </div>
      <ng-template #courseGrid>
        <app-course-card 
          *ngFor="let course of (courses$ | async); trackBy: trackByCourseId" 
          [course]="course" 
          (enrollRequested)="onEnroll($event)">
        </app-course-card>
      </ng-template>
      <p *ngIf="selectedCourseId">Selected course ID: {{ selectedCourseId }}</p>
    </div>
  `
})
export class CourseListComponent implements OnInit {
  isLoading = true;
  selectedCourseId: number | null = null;
  courses$: Observable<Course[]>;

  constructor(private store: Store) {
    this.courses$ = this.store.select(selectAllCourses);
  }

  ngOnInit() {
    setTimeout(() => this.isLoading = false, 1500);
    this.store.dispatch(loadCourses());
  }

  trackByCourseId(index: number, course: Course) { return course.id; }
  onEnroll(courseId: number) {
    console.log('Enrolling in course: ' + courseId);
    this.selectedCourseId = courseId;
  }
}
