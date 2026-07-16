import { Injectable } from '@angular/core';
import { Course } from '../models/course.model';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class CourseService {
  constructor(private http: HttpClient) {}
  getCourses(): Observable<Course[]> {
    return this.http.get<Course[]>('http://localhost:3000/courses');
  }
}
