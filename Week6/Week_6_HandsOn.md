# Week 6 Hands-On Assignments

## 2. Git-HOL

Here is how we can ignore `.log` files and `log` folders in Git:

1. **Create the files and folders:**
   First, create a `.log` file and a `log` folder in the working directory:
   ```bash
   mkdir log
   touch test.log
   ```

2. **Update the `.gitignore` file:**
   Create or open the `.gitignore` file and add the rules so Git ignores them on commit:
   ```bash
   echo "*.log" >> .gitignore
   echo "log/" >> .gitignore
   ```

3. **Verify the status:**
   ```bash
   git status
   ```
   You will notice that `test.log` and the `log` folder are not listed under untracked files. Only the `.gitignore` file will be shown as an untracked file ready to be added, proving that our ignore rules are working correctly for the working directory and local repository.

## 3. Git-HOL

Here are the steps to practice branching and merging:

**Branching:**
1. Create a new branch called "GitNewBranch":
   ```bash
   git branch GitNewBranch
   ```
2. List all branches and observe the `*` indicating the current active branch:
   ```bash
   git branch -a
   ```
3. Switch to the newly created branch and add some files:
   ```bash
   git checkout GitNewBranch
   echo "Some content for the new feature" > feature.txt
   ```
4. Commit the changes to this branch:
   ```bash
   git add feature.txt
   git commit -m "Added feature.txt in GitNewBranch"
   ```
5. Check the status:
   ```bash
   git status
   ```

**Merging:**
1. Switch back to the master (or trunk) branch:
   ```bash
   git checkout master
   ```
2. List differences between the master and the new branch via command line interface:
   ```bash
   git diff master..GitNewBranch
   ```
3. To view visual differences using the P4Merge tool:
   ```bash
   git difftool -t p4merge master..GitNewBranch
   ```
4. Merge the source branch into the trunk:
   ```bash
   git merge GitNewBranch
   ```
5. Observe the log graph to see the detailed merge history:
   ```bash
   git log --oneline --graph --decorate
   ```
6. Clean up by deleting the branch after merging, and check the status:
   ```bash
   git branch -d GitNewBranch
   git status
   ```

## 4. Git-HOL

Here is how to resolve merge conflicts effectively when multiple users update the same file:

1. Verify master is clean:
   ```bash
   git status
   ```
2. Create and switch to `GitWork` branch, and add a file:
   ```bash
   git checkout -b GitWork
   echo "Initial content" > hello.xml
   ```
3. Update `hello.xml` and observe the status:
   ```bash
   echo "<greeting>Hello from branch</greeting>" > hello.xml
   git status
   ```
4. Commit the changes to reflect in the branch:
   ```bash
   git add hello.xml
   git commit -m "Updated hello.xml in GitWork branch"
   ```
5. Switch to master, create the same file with different content, and commit:
   ```bash
   git checkout master
   echo "<greeting>Hello from master</greeting>" > hello.xml
   git add hello.xml
   git commit -m "Added hello.xml in master"
   ```
6. Observe the commit history for all branches:
   ```bash
   git log --oneline --graph --decorate --all
   ```
7. Check the differences with Git diff tool:
   ```bash
   git diff master..GitWork
   ```
   For better visualization using P4Merge:
   ```bash
   git difftool -t p4merge master..GitWork
   ```
8. Attempt to merge the branch into master (this will cause a conflict):
   ```bash
   git merge GitWork
   ```
9. Observe the git markup inside the conflicted file:
   ```bash
   cat hello.xml
   ```
10. Use the 3-way merge tool to resolve the conflict:
    ```bash
    git mergetool -t p4merge
    ```
    *(Resolve the conflicts and save in the tool)*
11. Commit the changes to the master once done with the conflict resolution:
    ```bash
    git commit -m "Resolved merge conflict for hello.xml"
    ```
12. Observe the git status and add the backup files (like `*.orig`) created by the merge tool to `.gitignore`, then commit it:
    ```bash
    echo "*.orig" >> .gitignore
    git add .gitignore
    git commit -m "Ignore merge tool backup files"
    ```
13. List all available branches and delete the merged branch:
    ```bash
    git branch
    git branch -d GitWork
    ```
14. Observe the final log tree:
    ```bash
    git log --oneline --graph --decorate
    ```

## 5. Git-HOL

Steps for cleaning up and pushing back to the remote Git repository:

1. Verify if the master branch is in a clean state:
   ```bash
   git status
   ```
2. List out all available branches to review your workspace:
   ```bash
   git branch -a
   ```
3. Pull the remote git repository to the master to ensure it is up-to-date:
   ```bash
   git pull origin master
   ```
4. Push the changes that are pending to the remote repository:
   ```bash
   git push origin master
   ```
5. Observe and verify on the remote server (e.g., GitHub/GitLab) that the changes are successfully reflected in the repository.

## Angular Hands-on

*(A humanized walkthrough of the Angular hands-on assignments for building the Student Course Portal)*

### Hands-On 1: Environment Setup & First Component
- We start by installing the CLI globally: `npm install -g @angular/cli`.
- Scaffold the portal project: `ng new student-course-portal --routing --style=css`.
- In our `notes.txt`, we document that `angular.json` configures the workspace, `package.json` manages dependencies, and `src/main.ts` bootstraps the application.
- We generate our layout components using the CLI: `ng g c components/header` and `ng g c pages/home`.
- We set up `app.component.html` with `<app-header>` and `<router-outlet>`.

### Hands-On 2: Data Binding & Lifecycle Hooks
- We add interpolations like `{{ portalName }}` to dynamically display the title.
- Utilize property binding `[disabled]="!isPortalActive"` and event binding `(click)="onEnrollClick()"` for interactive elements.
- Explore two-way binding with `[(ngModel)]="searchTerm"` by importing `FormsModule`.
- Implement `ngOnInit` for component initialization and `ngOnChanges` to observe input updates in our custom `CourseCardComponent`.

### Hands-On 3: Directives & Pipes
- Implement `*ngIf` to handle loading states smoothly and `*ngFor` to render multiple `CourseCardComponent` instances.
- Add `trackBy` for performance optimizations during array re-renders.
- Use `[ngClass]` and `[ngStyle]` to conditionally apply enrolled styles and color-code card borders based on the student's grade status.
- Create a custom directive `@HostListener('mouseenter')` for highlighting cards dynamically on hover, and a custom pipe to neatly format course credits.

### Hands-On 4 & 5: Forms (Template-Driven & Reactive)
- Build the `EnrollmentFormComponent` using template-driven forms (`#enrollForm="ngForm"`) with built-in validation attributes (`required`, `minlength`).
- Handle dynamic error displays by checking `nameCtrl.touched` and `nameCtrl.errors`.
- We then rebuild the experience using Reactive Forms utilizing the `FormBuilder` service for better scalability.
- Apply custom synchronous validators (`noCourseCode`) and asynchronous validators (`simulateEmailCheck`), as well as a `FormArray` for allowing dynamic additions of multiple courses.

### Hands-On 6: Services & Dependency Injection
- Generate a singleton `CourseService` utilizing `providedIn: 'root'` to manage our mock course data and make it available application-wide.
- Create an `EnrollmentService` for enrolling/unenrolling logic that interacts with other services.
- Demonstrate component-level Dependency Injection by scoping a `NotificationService` specifically to a component and its children, instead of polluting the root space.

### Hands-On 7: Routing & Guards
- Define standard routes, dynamic routes (`courses/:id`), and nested child routes (`courses/child`).
- Extract dynamic routing parameters using `ActivatedRoute.snapshot.paramMap`.
- Enable Lazy Loading for the enrollment features to drastically optimize our bundle size via `loadChildren`.
- Implement `CanActivate` guards to protect profile routes and `CanDeactivate` guards to warn users of unsaved form data before navigating away.

### Hands-On 8: HTTP Client & RxJS
- Replace the mocked static arrays in `CourseService` with actual `HttpClient` API calls (`get`, `post`).
- Consume Observable data directly in our templates beautifully using the `async` pipe.
- Apply powerful RxJS operators like `map` and `catchError` for transformations, and `switchMap` for handling dependent search requests to avoid race conditions.
- Implement custom `HttpInterceptors` to automatically append Authorization tokens to outgoing requests and elegantly handle a global loading spinner.

### Hands-On 9 & 10: NgRx State Management & Testing
- Integrate `@ngrx/store` and `@ngrx/effects` for scalable application state.
- Configure strongly-typed actions, pure reducers, and memoized selectors for courses and enrollments, keeping our components clean and pushing all side-effects to NgRx Effects.
- Finally, wrap up the portal by writing Jasmine & Karma unit tests, utilizing `TestBed` for thoroughly testing `@Inputs`, `@Outputs`, UI events, and mocking the NgRx store state.
