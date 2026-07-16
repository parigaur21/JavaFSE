import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
@Component({ selector: 'app-header', standalone: true, imports: [RouterLink], template: `<nav><h1>Student Course Portal</h1> <a routerLink="/">Home</a> | <a routerLink="/courses">Courses</a> | <a routerLink="/profile">Profile</a> | <a routerLink="/enroll">Enroll (Lazy)</a></nav>` })
export class HeaderComponent {}
