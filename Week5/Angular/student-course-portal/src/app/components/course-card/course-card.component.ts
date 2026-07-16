import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Course } from '../../models/course.model';
import { HighlightDirective } from '../../directives/highlight.directive';
import { CreditLabelPipe } from '../../pipes/credit-label.pipe';

@Component({
  selector: 'app-course-card',
  standalone: true,
  imports: [CommonModule, HighlightDirective, CreditLabelPipe],
  template: `
    <div [ngClass]="getCardClasses()" [ngStyle]="{'border-left-color': getBorderColor()}" appHighlight="lightblue">
      <h3>{{ course.name }}</h3>
      <p>{{ course.code }}</p>
      <p>{{ course.credits | creditLabel }}</p>
      <ng-container [ngSwitch]="course.gradeStatus">
        <span *ngSwitchCase="'passed'" class="badge green">Passed</span>
        <span *ngSwitchCase="'failed'" class="badge red">Failed</span>
        <span *ngSwitchCase="'pending'" class="badge grey">Pending</span>
      </ng-container>
      <button (click)="enrollRequested.emit(course.id)">Enroll</button>
      <button (click)="isExpanded = !isExpanded">Show Details</button>
    </div>
  `
})
export class CourseCardComponent implements OnChanges {
  @Input() course!: Course;
  @Output() enrollRequested = new EventEmitter<number>();
  isExpanded = false;

  ngOnChanges(changes: SimpleChanges) {
    if (changes['course']) {
      console.log('Previous:', changes['course'].previousValue, 'Current:', changes['course'].currentValue);
    }
  }

  getCardClasses() { return { 'card--enrolled': false, 'card--full': this.course.credits >= 4, 'expanded': this.isExpanded }; }
  getBorderColor() { return this.course.gradeStatus === 'passed' ? 'green' : this.course.gradeStatus === 'failed' ? 'red' : 'grey'; }
}
