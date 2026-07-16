import React from 'react';
import styles from './CohortDetails.module.css';
export default function CohortDetails() {
    const cohorts = [
        { name: 'Cohort A', status: 'ongoing' },
        { name: 'Cohort B', status: 'completed' }
    ];
    return (
        <div className={styles.box}>
            {cohorts.map(c => (
                <div key={c.name}>
                    <h3 style={{ color: c.status === 'ongoing' ? 'green' : 'blue' }}>{c.name}</h3>
                    <dt>Status: {c.status}</dt>
                </div>
            ))}
        </div>
    );
}
