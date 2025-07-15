CREATE DATABASE Opiod_Effectiveness;
-- SQL Implementation for Opioid Effectiveness Database
-- Part 2: Create Tables and Insert Sample Data
USE Opiod_Effectiveness;
-- Create Tables (using the schema from Part 1)
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    Age INT NOT NULL CHECK (Age >= 0 AND Age <= 120),
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
    Ethnicity VARCHAR(50) NOT NULL,
    MedicalHistory TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    DoctorName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    LicenseNumber VARCHAR(50) UNIQUE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Surgeries (
    SurgeryID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    SurgeryType VARCHAR(100) NOT NULL,
    SurgeryDate DATE NOT NULL,
    PostOpCarePlan TEXT,
    Duration INT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE RESTRICT
);

CREATE TABLE Opioid_Administration (
    OpioidID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    OpioidType VARCHAR(50) NOT NULL,
    Dosage DECIMAL(10,2) NOT NULL CHECK (Dosage > 0),
    Frequency VARCHAR(50) NOT NULL,
    Duration INT NOT NULL CHECK (Duration > 0),
    Route VARCHAR(20) NOT NULL CHECK (Route IN ('Oral', 'Intravenous', 'Intramuscular', 'Sublingual', 'Transdermal')),
    StartDate DATE NOT NULL,
    EndDate DATE,
    PrescribedBy INT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (PrescribedBy) REFERENCES Doctors(DoctorID) ON DELETE SET NULL
);

CREATE TABLE Pain_Records (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    PainScale INT NOT NULL CHECK (PainScale >= 0 AND PainScale <= 10),
    TimeToRelief INT,
    PainFreeDays INT CHECK (PainFreeDays >= 0),
    AssessmentDate DATE NOT NULL,
    AssessmentTime TIME NOT NULL,
    Notes TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);

CREATE TABLE Adverse_Events (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    EventType VARCHAR(100) NOT NULL,
    EventDescription TEXT NOT NULL,
    EventDate DATE NOT NULL,
    Severity VARCHAR(20) NOT NULL CHECK (Severity IN ('Mild', 'Moderate', 'Severe', 'Critical')),
    ReportedBy INT,
    TreatmentRequired BOOLEAN DEFAULT FALSE,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (ReportedBy) REFERENCES Doctors(DoctorID) ON DELETE SET NULL
);

-- Insert Sample Data (7+ rows as required)

-- Insert Doctors
INSERT INTO Doctors (DoctorName, Specialization, LicenseNumber) VALUES
('Dr. Sarah Johnson', 'Orthopedic Surgery', 'MD12345'),
('Dr. Michael Chen', 'Anesthesiology', 'MD12346'),
('Dr. Emily Rodriguez', 'Pain Management', 'MD12347'),
('Dr. David Wilson', 'General Surgery', 'MD12348'),
('Dr. Lisa Thompson', 'Cardiac Surgery', 'MD12349'),
('Dr. James Brown', 'Neurosurgery', 'MD12350'),
('Dr. Maria Garcia', 'Oncology Surgery', 'MD12351');

-- Insert Patients
INSERT INTO Patients (Age, Gender, Ethnicity, MedicalHistory) VALUES
(45, 'Male', 'Caucasian', 'Hypertension, Diabetes Type 2'),
(62, 'Female', 'African American', 'Arthritis, Previous cardiac surgery'),
(38, 'Female', 'Hispanic', 'No significant medical history'),
(71, 'Male', 'Asian', 'COPD, Hypertension'),
(29, 'Female', 'Caucasian', 'Asthma, Anxiety disorder'),
(56, 'Male', 'Hispanic', 'Obesity, Sleep apnea'),
(43, 'Female', 'African American', 'Migraines, Depression'),
(67, 'Male', 'Caucasian', 'Coronary artery disease, Diabetes'),
(34, 'Female', 'Asian', 'Healthy, no medical history'),
(52, 'Male', 'Native American', 'Arthritis, Chronic pain');

-- Insert Surgeries
INSERT INTO Surgeries (PatientID, DoctorID, SurgeryType, SurgeryDate, PostOpCarePlan, Duration) VALUES
(1, 1, 'Knee Replacement', '2024-01-15', 'Physical therapy, pain management', 120),
(2, 5, 'Cardiac Bypass', '2024-01-20', 'Cardiac rehabilitation, medication management', 240),
(3, 4, 'Appendectomy', '2024-02-01', 'Standard post-op care, early mobilization', 45),
(4, 6, 'Lumbar Fusion', '2024-02-10', 'Spinal rehabilitation, pain management', 180),
(5, 4, 'Cholecystectomy', '2024-02-15', 'Standard laparoscopic recovery', 60),
(6, 1, 'Hip Replacement', '2024-03-01', 'Physical therapy, weight management', 150),
(7, 7, 'Breast Cancer Surgery', '2024-03-05', 'Oncology follow-up, wound care', 90),
(8, 5, 'Valve Replacement', '2024-03-10', 'Cardiac monitoring, anticoagulation', 300),
(9, 4, 'Hernia Repair', '2024-03-15', 'Activity restrictions, wound care', 75),
(10, 6, 'Spinal Tumor Removal', '2024-03-20', 'Neurological monitoring, rehabilitation', 360);

-- Insert Opioid Administration
INSERT INTO Opioid_Administration (PatientID, OpioidType, Dosage, Frequency, Duration, Route, StartDate, EndDate, PrescribedBy) VALUES
(1, 'Oxycodone', 10.00, 'Every 6 hours', 5, 'Oral', '2024-01-15', '2024-01-20', 2),
(2, 'Morphine', 15.00, 'Every 4 hours', 7, 'Intravenous', '2024-01-20', '2024-01-27', 2),
(3, 'Hydrocodone', 5.00, 'Every 8 hours', 3, 'Oral', '2024-02-01', '2024-02-04', 2),
(4, 'Fentanyl', 75.00, 'Continuous', 10, 'Transdermal', '2024-02-10', '2024-02-20', 3),
(5, 'Tramadol', 50.00, 'Every 6 hours', 4, 'Oral', '2024-02-15', '2024-02-19', 2),
(6, 'Oxycodone', 15.00, 'Every 4 hours', 8, 'Oral', '2024-03-01', '2024-03-09', 3),
(7, 'Morphine', 10.00, 'Every 6 hours', 6, 'Oral', '2024-03-05', '2024-03-11', 2),
(8, 'Hydromorphone', 2.00, 'Every 4 hours', 9, 'Intravenous', '2024-03-10', '2024-03-19', 2),
(9, 'Codeine', 30.00, 'Every 8 hours', 3, 'Oral', '2024-03-15', '2024-03-18', 2),
(10, 'Fentanyl', 100.00, 'Continuous', 14, 'Intravenous', '2024-03-20', '2024-04-03', 3);

-- Insert Pain Records
INSERT INTO Pain_Records (PatientID, PainScale, TimeToRelief, PainFreeDays, AssessmentDate, AssessmentTime, Notes) VALUES
(1, 8, 45, 2, '2024-01-15', '14:00:00', 'Severe post-operative pain'),
(1, 6, 30, 3, '2024-01-16', '08:00:00', 'Pain improving with medication'),
(1, 4, 20, 5, '2024-01-18', '12:00:00', 'Significant improvement'),
(2, 9, 60, 1, '2024-01-20', '16:00:00', 'Severe cardiac surgery pain'),
(2, 7, 40, 2, '2024-01-22', '10:00:00', 'Gradual improvement'),
(3, 6, 25, 4, '2024-02-01', '18:00:00', 'Moderate post-appendectomy pain'),
(3, 3, 15, 6, '2024-02-03', '14:00:00', 'Rapid recovery'),
(4, 9, 90, 1, '2024-02-10', '20:00:00', 'Severe spinal surgery pain'),
(4, 8, 75, 1, '2024-02-12', '16:00:00', 'Persistent high pain levels'),
(5, 5, 30, 3, '2024-02-15', '12:00:00', 'Moderate laparoscopic pain'),
(6, 7, 50, 2, '2024-03-01', '15:00:00', 'Hip replacement pain'),
(7, 6, 35, 3, '2024-03-05', '11:00:00', 'Post-mastectomy pain'),
(8, 8, 70, 1, '2024-03-10', '19:00:00', 'Severe cardiac surgery pain'),
(9, 4, 20, 5, '2024-03-15', '13:00:00', 'Mild hernia repair pain'),
(10, 9, 120, 0, '2024-03-20', '22:00:00', 'Severe neurosurgical pain');

-- Insert Adverse Events
INSERT INTO Adverse_Events (PatientID, EventType, EventDescription, EventDate, Severity, ReportedBy, TreatmentRequired) VALUES
(1, 'Nausea', 'Patient experienced nausea after opioid administration', '2024-01-16', 'Mild', 2, TRUE),
(2, 'Respiratory Depression', 'Decreased respiratory rate observed', '2024-01-22', 'Severe', 2, TRUE),
(4, 'Constipation', 'Severe constipation requiring intervention', '2024-02-14', 'Moderate', 3, TRUE),
(6, 'Dizziness', 'Patient reported dizziness and lightheadedness', '2024-03-03', 'Mild', 3, FALSE),
(8, 'Confusion', 'Acute confusion and disorientation', '2024-03-12', 'Moderate', 2, TRUE),
(10, 'Allergic Reaction', 'Skin rash and itching after opioid administration', '2024-03-22', 'Moderate', 3, TRUE),
(2, 'Dependency Signs', 'Patient requesting medication earlier than scheduled', '2024-01-25', 'Moderate', 2, TRUE),
(4, 'Withdrawal Symptoms', 'Mild withdrawal symptoms when tapering', '2024-02-19', 'Mild', 3, TRUE);

-- Data Analysis Queries

-- 1. Opioid Use Patterns Analysis
SELECT 
    OpioidType,
    COUNT(*) as TotalAdministrations,
    AVG(Dosage) as AvgDosage,
    AVG(Duration) as AvgDuration,
    COUNT(DISTINCT PatientID) as UniquePatients
FROM Opioid_Administration
GROUP BY OpioidType
ORDER BY TotalAdministrations DESC;

-- 2. Pain Management Effectiveness Analysis
SELECT 
    oa.OpioidType,
    AVG(pr.PainScale) as AvgPainScore,
    AVG(pr.TimeToRelief) as AvgTimeToRelief,
    AVG(pr.PainFreeDays) as AvgPainFreeDays,
    COUNT(pr.RecordID) as TotalPainRecords
FROM Opioid_Administration oa
JOIN Pain_Records pr ON oa.PatientID = pr.PatientID
GROUP BY oa.OpioidType
ORDER BY AvgPainScore DESC;

-- 3. Patient Demographics and Pain Outcomes
SELECT 
    p.Gender,
    p.Ethnicity,
    COUNT(DISTINCT p.PatientID) as PatientCount,
    AVG(pr.PainScale) as AvgPainScore,
    AVG(pr.PainFreeDays) as AvgPainFreeDays
FROM Patients p
JOIN Pain_Records pr ON p.PatientID = pr.PatientID
GROUP BY p.Gender, p.Ethnicity
ORDER BY AvgPainScore DESC;

-- 4. Adverse Events Analysis
SELECT 
    ae.EventType,
    ae.Severity,
    COUNT(*) as EventCount,
    COUNT(DISTINCT ae.PatientID) as AffectedPatients,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Adverse_Events)), 2) as PercentageOfEvents
FROM Adverse_Events ae
GROUP BY ae.EventType, ae.Severity
ORDER BY EventCount DESC;

-- 5. Opioid Type vs Adverse Events Correlation
SELECT 
    oa.OpioidType,
    COUNT(DISTINCT ae.EventID) as AdverseEventCount,
    COUNT(DISTINCT oa.PatientID) as TotalPatients,
    ROUND((COUNT(DISTINCT ae.EventID) * 100.0 / COUNT(DISTINCT oa.PatientID)), 2) as AdverseEventRate
FROM Opioid_Administration oa
LEFT JOIN Adverse_Events ae ON oa.PatientID = ae.PatientID
GROUP BY oa.OpioidType
ORDER BY AdverseEventRate DESC;

-- 6. Pain Level Trends Over Time
SELECT 
    p.PatientID,
    p.Age,
    p.Gender,
    pr.AssessmentDate,
    pr.PainScale,
    LAG(pr.PainScale) OVER (PARTITION BY p.PatientID ORDER BY pr.AssessmentDate) as PreviousPainScale,
    (pr.PainScale - LAG(pr.PainScale) OVER (PARTITION BY p.PatientID ORDER BY pr.AssessmentDate)) as PainChange
FROM Patients p
JOIN Pain_Records pr ON p.PatientID = pr.PatientID
ORDER BY p.PatientID, pr.AssessmentDate;

-- 7. High-Risk Patients Identification
SELECT 
    p.PatientID,
    p.Age,
    p.Gender,
    p.Ethnicity,
    COUNT(DISTINCT oa.OpioidID) as OpioidAdministrations,
    MAX(pr.PainScale) as MaxPainScore,
    COUNT(DISTINCT ae.EventID) as AdverseEvents,
    AVG(oa.Duration) as AvgOpioidDuration
FROM Patients p
LEFT JOIN Opioid_Administration oa ON p.PatientID = oa.PatientID
LEFT JOIN Pain_Records pr ON p.PatientID = pr.PatientID
LEFT JOIN Adverse_Events ae ON p.PatientID = ae.PatientID
GROUP BY p.PatientID, p.Age, p.Gender, p.Ethnicity
HAVING COUNT(DISTINCT oa.OpioidID) > 1 OR COUNT(DISTINCT ae.EventID) > 1 OR AVG(oa.Duration) > 7
ORDER BY AdverseEvents DESC, AvgOpioidDuration DESC;

-- 8. Surgery Type and Pain Management Effectiveness
SELECT 
    s.SurgeryType,
    COUNT(DISTINCT s.PatientID) as TotalPatients,
    AVG(pr.PainScale) as AvgPainScore,
    AVG(pr.TimeToRelief) as AvgTimeToRelief,
    AVG(oa.Duration) as AvgOpioidDuration,
    COUNT(DISTINCT ae.EventID) as TotalAdverseEvents
FROM Surgeries s
LEFT JOIN Pain_Records pr ON s.PatientID = pr.PatientID
LEFT JOIN Opioid_Administration oa ON s.PatientID = oa.PatientID
LEFT JOIN Adverse_Events ae ON s.PatientID = ae.PatientID
GROUP BY s.SurgeryType
ORDER BY AvgPainScore DESC;

-- 9. Potential Opioid Misuse Indicators
SELECT 
    p.PatientID,
    p.Age,
    p.Gender,
    COUNT(DISTINCT oa.OpioidID) as MultipleOpioidTypes,
    SUM(oa.Duration) as TotalOpioidDays,
    COUNT(CASE WHEN ae.EventType = 'Dependency Signs' THEN 1 END) as DependencyEvents,
    COUNT(CASE WHEN ae.EventType = 'Withdrawal Symptoms' THEN 1 END) as WithdrawalEvents,
    CASE 
        WHEN SUM(oa.Duration) > 30 OR COUNT(CASE WHEN ae.EventType IN ('Dependency Signs', 'Withdrawal Symptoms') THEN 1 END) > 0 
        THEN 'High Risk'
        WHEN SUM(oa.Duration) > 14 OR COUNT(DISTINCT oa.OpioidID) > 2 
        THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END as RiskLevel
FROM Patients p
LEFT JOIN Opioid_Administration oa ON p.PatientID = oa.PatientID
LEFT JOIN Adverse_Events ae ON p.PatientID = ae.PatientID
GROUP BY p.PatientID, p.Age, p.Gender
ORDER BY TotalOpioidDays DESC;

-- 10. Dosage Patterns and Effectiveness
SELECT 
    oa.OpioidType,
    CASE 
        WHEN oa.Dosage < 10 THEN 'Low Dose'
        WHEN oa.Dosage BETWEEN 10 AND 50 THEN 'Medium Dose'
        ELSE 'High Dose'
    END as DosageCategory,
    COUNT(*) as AdministrationCount,
    AVG(pr.PainScale) as AvgPainScore,
    AVG(pr.TimeToRelief) as AvgTimeToRelief,
    COUNT(DISTINCT ae.EventID) as AdverseEventCount
FROM Opioid_Administration oa
LEFT JOIN Pain_Records pr ON oa.PatientID = pr.PatientID
LEFT JOIN Adverse_Events ae ON oa.PatientID = ae.PatientID
GROUP BY oa.OpioidType, DosageCategory
ORDER BY oa.OpioidType, DosageCategory;