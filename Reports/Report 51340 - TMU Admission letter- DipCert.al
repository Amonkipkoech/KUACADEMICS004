report 51340 "TMU Admission letter- Dip/Cert"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/TMU Admission letter- DipCert.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
        {
            column(AdmissionNo_AdmissionFormHeader; "ACA-Applic. Form Header"."Application No.")
            {
            }
            column(Date_AdmissionFormHeader; "ACA-Applic. Form Header".Date)
            {
            }
            column(AdmissionType_AdmissionFormHeader; "ACA-Applic. Form Header"."Settlement Type")
            {
            }
            column(JABSNo_AdmissionFormHeader; "ACA-Applic. Form Header"."Admission No")
            {
            }
            column(AcademicYear_AdmissionFormHeader; "ACA-Applic. Form Header"."Academic Year")
            {
            }
            column(ApplicationNo_AdmissionFormHeader; "ACA-Applic. Form Header"."Admission No" + ':')
            {
            }
            column(Surname_AdmissionFormHeader; "ACA-Applic. Form Header".Surname)
            {
            }
            column(OtherNames_AdmissionFormHeader; "ACA-Applic. Form Header"."Other Names")
            {
            }
            column(FacultyAdmittedTo_AdmissionFormHeader; "ACA-Applic. Form Header".School1)
            {
            }
            column(DegreeAdmittedTo_AdmissionFormHeader; "ACA-Applic. Form Header"."First Degree Choice")
            {
            }
            column(DateOfBirth_AdmissionFormHeader; "ACA-Applic. Form Header"."Date Of Birth")
            {
            }
            column(Gender_AdmissionFormHeader; "ACA-Applic. Form Header".Gender)
            {
            }
            column(MaritalStatus_AdmissionFormHeader; "ACA-Applic. Form Header"."Marital Status")
            {
            }
            column(SpouseName_AdmissionFormHeader; '  ')
            {
            }
            column(SpouseAddress1_AdmissionFormHeader; '   ')
            {
            }
            column(SpouseAddress2_AdmissionFormHeader; '      ')
            {
            }
            column(SpouseAddress3_AdmissionFormHeader; '    ')
            {
            }
            column(PlaceOfBirthVillage_AdmissionFormHeader; '    ')
            {
            }
            column(PlaceOfBirthLocation_AdmissionFormHeader; '       ')
            {
            }
            column(PlaceOfBirthDistrict_AdmissionFormHeader; '             ')
            {
            }
            column(NameofChief_AdmissionFormHeader; '                 ')
            {
            }
            column(NearestPoliceStation_AdmissionFormHeader; '                        ')
            {
            }
            column(Nationality_AdmissionFormHeader; "ACA-Applic. Form Header".Nationality)
            {
            }
            column(Religion_AdmissionFormHeader; '.')
            {
            }
            column(CorrespondenceAddress1_AdmissionFormHeader; "ACA-Applic. Form Header"."Address for Correspondence1")
            {
            }
            column(CorrespondenceAddress2_AdmissionFormHeader; "ACA-Applic. Form Header"."Address for Correspondence2")
            {
            }
            column(CorrespondenceAddress3_AdmissionFormHeader; "ACA-Applic. Form Header"."Address for Correspondence3")
            {
            }
            column(TelephoneNo1_AdmissionFormHeader; "ACA-Applic. Form Header"."Telephone No. 1")
            {
            }
            column(TelephoneNo2_AdmissionFormHeader; "ACA-Applic. Form Header"."Telephone No. 2")
            {
            }
            column(FaxNo_AdmissionFormHeader; ',.')
            {
            }
            column(EMail_AdmissionFormHeader; "ACA-Applic. Form Header".Email)
            {
            }
            column(StageAdmittedTo_AdmissionFormHeader; "ACA-Applic. Form Header"."First Choice Stage")
            {
            }
            column(SemesterAdmittedTo_AdmissionFormHeader; "ACA-Applic. Form Header"."First Choice Semester")
            {
            }
            column(SettlementType_AdmissionFormHeader; "ACA-Applic. Form Header"."Settlement Type")
            {
            }
            column(IntakeCode_AdmissionFormHeader; "ACA-Applic. Form Header"."Intake Code")
            {
            }
            column(IDNumber_AdmissionFormHeader; "ACA-Applic. Form Header"."ID Number")
            {
            }
            column(Title; "ACA-Applic. Form Header".Title)
            {
            }
            column(Campus_AdmissionFormHeader; "ACA-Applic. Form Header".Campus)
            {
            }
            column(CompName; UPPERCASE(CompName))
            {
            }
            column(RepDate; ReportDate)
            {
            }
            column(FNames; FullNames)
            {
            }
            column(YearName; YearName)
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(DateStr; DateStr)
            {
            }
            column(Faculty; FacultyName)
            {
            }
            column(ttl; ttl)
            {
            }
            column(repEndDate; repEndDate)
            {
            }
            column(signName; applicSet."Admission Letter Signatory Nam")
            {
            }
            column(SignTitle; applicSet."Admission Letter Sign. Title")
            {
            }
            column(titleAndFullName; "ACA-Applic. Form Header".Surname)
            {
            }
            column(ProgCategory; ProgCategory)
            {
            }
            column(counted1; counted2[1])
            {
            }
            column(counted2; counted2[2])
            {
            }
            column(counted3; counted2[3])
            {
            }
            column(counted4; counted2[4])
            {
            }
            column(counted5; counted2[5])
            {
            }
            column(counted6; counted2[6])
            {
            }
            column(counted7; counted2[7])
            {
            }
            column(counted8; counted2[8])
            {
            }
            column(counted9; counted2[9])
            {
            }
            column(counted10; counted2[10])
            {
            }
            column(counted11; counted2[11])
            {
            }
            column(counted12; counted2[12])
            {
            }
            column(counted13; counted2[13])
            {
            }
            column(chargeDesc1; chargeDesc[1])
            {
            }
            column(chargeDesc2; chargeDesc[2])
            {
            }
            column(chargeDesc3; chargeDesc[3])
            {
            }
            column(chargeDesc4; chargeDesc[4])
            {
            }
            column(chargeDesc5; chargeDesc[5])
            {
            }
            column(chargeDesc6; chargeDesc[6])
            {
            }
            column(chargeDesc7; chargeDesc[7])
            {
            }
            column(chargeDesc8; chargeDesc[8])
            {
            }
            column(chargeDesc9; chargeDesc[9])
            {
            }
            column(chargeDesc10; chargeDesc[10])
            {
            }
            column(chargeDesc11; chargeDesc[11])
            {
            }
            column(chargeDesc12; chargeDesc[12])
            {
            }
            column(chargeDesc13; chargeDesc[13])
            {
            }
            column(ChargeAmount1; ChargeAmount[1])
            {
            }
            column(ChargeAmount2; ChargeAmount[2])
            {
            }
            column(ChargeAmount3; ChargeAmount[3])
            {
            }
            column(ChargeAmount4; ChargeAmount[4])
            {
            }
            column(ChargeAmount5; ChargeAmount[5])
            {
            }
            column(ChargeAmount6; ChargeAmount[6])
            {
            }
            column(ChargeAmount7; ChargeAmount[7])
            {
            }
            column(ChargeAmount8; ChargeAmount[8])
            {
            }
            column(ChargeAmount9; ChargeAmount[9])
            {
            }
            column(ChargeAmount10; ChargeAmount[10])
            {
            }
            column(ChargeAmount11; ChargeAmount[11])
            {
            }
            column(ChargeAmount12; ChargeAmount[12])
            {
            }
            column(ChargeAmount13; ChargeAmount[13])
            {
            }
            column(ChargeTotal; ChargeTotal)
            {
            }

            trigger OnAfterGetRecord()
            var
                TTTT: Text[30];
            begin
                IF applicSet.GET() THEN BEGIN
                END;
                CLEAR(ttl);
                CLEAR(repEndDate);
                IF Gender = Gender::Male THEN ttl := 'MR. ' ELSE ttl := 'MRS/MISS';
                FullNames := "ACA-Applic. Form Header".Surname + ' ' + "ACA-Applic. Form Header"."Other Names";
                ProgName := '';
                IF Prog.GET("ACA-Applic. Form Header"."First Degree Choice") THEN
                    ProgName := Prog.Description;

                IF IntakeRec.GET("ACA-Applic. Form Header"."Intake Code") THEN BEGIN
                    IntakeRec.TESTFIELD(IntakeRec."Reporting Date");
                    ReportDate := FORMAT(IntakeRec."Reporting Date", 0, '<Day> <Month Text>') + ' ' + FORMAT(DATE2DMY(IntakeRec."Reporting Date", 3));
                    repEndDate := FORMAT(IntakeRec."Reporting End Date", 0, '<Day> <Month Text>') + ' ' + FORMAT(DATE2DMY(IntakeRec."Reporting End Date", 3));
                END;
                DateStr := FORMAT(TODAY, 0, '<Day> <Month Text>') + ' ' + FORMAT(DATE2DMY(TODAY, 3));

                FacultyName := '';
                FacRec.RESET;
                // FacRec.SETRANGE(FacRec.Code,"ACA-Adm. Form Header"."Faculty Admitted To");
                IF FacRec.FIND('-') THEN
                    FacultyName := FacRec.Name;

                IF "ACA-Applic. Form Header"."First Choice Stage" = 'Y1S1' THEN
                    YearName := 'Year 1 Semester 1' ELSE
                    IF
"ACA-Applic. Form Header"."First Choice Stage" = 'Y2S1' THEN
                        YearName := 'Second Year First Semester' ELSE
                        IF
"ACA-Applic. Form Header"."First Choice Stage" = 'Y3S1' THEN
                            YearName := 'Third Year First Semester' ELSE
                            IF
"ACA-Applic. Form Header"."First Choice Stage" = 'Y2S1' THEN
                                YearName := 'Fourth Year First Semester';
            end;

            trigger OnPreDataItem()
            begin
                IF CompInfo.GET THEN
                    CompName := CompInfo.Name;
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

    var
        CompName: Text[50];
        ReportDate: Text;
        FullNames: Text[100];
        ProgName: Code[100];
        Prog: Record 61511;
        IntakeRec: Record 61383;
        ComenceDate: Date;
        DateStr: Text[50];
        FacultyName: Text[100];
        FacRec: Record 349;
        CompInfo: Record 79;
        YearName: Text[50];
        ttl: Text;
        repEndDate: Text;
        applicSet: Record 61367;
        FeeByStage: Record 61523;
        progCharges: Record 61533;
        counted: Integer;
        counted2: array[13] of Integer;
        chargeDesc: array[13] of Code[50];
        ChargeAmount: array[13] of Decimal;
        ChargeTotal: Decimal;
        ProgCategory: Code[100];
        applic: Record 61358;
        title: Code[10];
}

