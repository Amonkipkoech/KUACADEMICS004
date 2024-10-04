report 65201 "Lecturer Appointment Laters"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Lecturer Appointment Laters.rdl';

    dataset
    {
        dataitem("Lect Load Batch Lines"; "Lect Load Batch Lines")
        {
            RequestFilterFields = "Semester Code", "Lecturer Code";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompPhones; CompanyInformation."Phone No." + '\' + CompanyInformation."Phone No. 2")
            {
            }
            column(CompMails; CompanyInformation."Home Page" + '\' + CompanyInformation."E-Mail")
            {
            }
            column(CompAddresses; CompanyInformation.Address + '\' + CompanyInformation."Address 2" + ' - ' + CompanyInformation.City)
            {
            }
            column(EmpNames; HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name")
            {
            }
            column(Salutations; FORMAT(HRMEmployeeC.Title))
            {
            }
            column(SemesterDesc; ACASemester.Description)
            {
            }
            column(Lname; HRMEmployeeC."Last Name")
            {
            }
            column(fName; HRMEmployeeC."First Name")
            {
            }
            column(MName; HRMEmployeeC."Middle Name")
            {
            }
            column(Amount; "Lect Load Batch Lines".Amount)
            {
            }
            column(Rangedescription; "Lect Load Batch Lines"."Semester Range Descption")
            {
            }
            column(FacName; "Lect Load Batch Lines"."Faculty Name")
            {
            }
            column(Semester; "Lect Load Batch Lines"."Semester Code")
            {
            }
            column(LectCode; "Lect Load Batch Lines"."Lecturer Code")
            {
            }
            column(Approve; "Lect Load Batch Lines".Approve)
            {
            }
            column(Reject; "Lect Load Batch Lines".Reject)
            {
            }
            column(RejectReason; "Lect Load Batch Lines"."Reject Reason")
            {
            }
            column(ClaimNo; "Lect Load Batch Lines"."Claim No.")
            {
            }
            column(PVNo; "Lect Load Batch Lines"."PV No.")
            {
            }
            column(ClaimInitiatedBy; "Lect Load Batch Lines"."Claim Initiated By")
            {
            }
            column(PVCreatedDate; "Lect Load Batch Lines"."PV Created Date")
            {
            }
            column(RejectBy; "Lect Load Batch Lines"."Rejected By")
            {
            }
            column(RejectDate; "Lect Load Batch Lines"."Rejected Time")
            {
            }
            column(CreatedBy; "Lect Load Batch Lines"."Created By")
            {
            }
            column(CreatedTime; "Lect Load Batch Lines"."Created Time")
            {
            }
            column(ClaimInitiatedDate; "Lect Load Batch Lines"."Claim Initiated Date")
            {
            }
            column(PVCreatedTime; "Lect Load Batch Lines"."PV Created Time")
            {
            }
            column(PVStatus; "Lect Load Batch Lines"."PV Status")
            {
            }
            column(ClaimStatus; "Lect Load Batch Lines"."Claim Status")
            {
            }
            column(ClaimCurrApprover; "Lect Load Batch Lines"."Claim Current Approver")
            {
            }
            column(PVCurrentApprove; "Lect Load Batch Lines"."PV Current Approver")
            {
            }
            column(Faculty; facultyName)
            {
            }
            column(AppointRefNo; "Lect Load Batch Lines"."Appointment Later Ref. No.")
            {
            }
            column(AppointRef; "Lect Load Batch Lines"."Appointment Later Ref.")
            {
            }
            column(PhoneNo; "Lect Load Batch Lines".Phone)
            {
            }
            column(UnitsCount; "Lect Load Batch Lines"."Courses Count")
            {
            }
            column(AppLetterRef; "Lect Load Batch Lines"."Appointment Later Ref. No.")
            {
            }
            column(AppLetterRef2; "Lect Load Batch Lines"."Appointment Later Ref.")
            {
            }
            column(SemRangeDesc; "Lect Load Batch Lines"."Semester Range Descption")
            {
            }
            column(ApprovalName; "Lect Load Batch Lines"."Approval Name")
            {
            }
            column(ApprovalTitle; "Lect Load Batch Lines"."Approval Title")
            {
            }
            column(GroupingConcortion; "Lect Load Batch Lines"."Semester Code" + "Lect Load Batch Lines"."Lecturer Code")
            {
            }
            dataitem("ACA-Lecturers Units"; "ACA-Lecturers Units")
            {
                DataItemLink = Lecturer = FIELD("Lecturer Code"),
                               Semester = FIELD("Semester Code");
                DataItemTableView = WHERE("Unit Cost" = FILTER(<> 0));
                column(UnitStage; "ACA-Lecturers Units".Stage)
                {
                }
                column(UnitProg; "ACA-Lecturers Units".Programme)
                {
                }
                column(UnitCode; "ACA-Lecturers Units".Unit)
                {
                }
                column(Lect; "ACA-Lecturers Units".Lecturer)
                {
                }
                column(UnitDesc; "ACA-Lecturers Units".Description)
                {
                }
                column(UnitCost; "ACA-Lecturers Units"."Unit Cost")
                {
                }
                column(Class; "ACA-Lecturers Units".Class)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "Lect Load Batch Lines"."Lecturer Code");
                IF HRMEmployeeC.FIND('-') THEN BEGIN
                END;
                ACASemester.RESET;
                ACASemester.SETRANGE(Code, "Lect Load Batch Lines"."Semester Code");
                IF ACASemester.FIND('-') THEN
                    ACASemester.VALIDATE(ACASemester.Description);
                CLEAR(facultyName);
                ACALecturersUnits.RESET;
                ACALecturersUnits.SETRANGE(Semester, "Lect Load Batch Lines"."Semester Code");
                ACALecturersUnits.SETRANGE(Lecturer, "Lect Load Batch Lines"."Lecturer Code");
                ACALecturersUnits.SETRANGE(Approved, TRUE);
                IF ACALecturersUnits.FIND('-') THEN BEGIN
                    IF ACAProgramme.GET(ACALecturersUnits.Programme) THEN BEGIN
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE("Dimension Code", 'SCHOOL');
                        DimensionValue.SETRANGE(Code, ACAProgramme."School Code");
                        IF DimensionValue.FIND('-') THEN BEGIN
                            facultyName := DimensionValue.Name;
                        END;
                    END;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
        END;
    end;

    var
        CompanyInformation: Record 79;
        HRMEmployeeC: Record 61188;
        ACASemester: Record 61692;
        ACALecturersUnits: Record 65202;
        ACAProgramme: Record 61511;
        DimensionValue: Record 349;
        facultyName: Text[250];
}

