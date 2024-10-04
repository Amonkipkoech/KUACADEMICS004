page 66611 "ACA-Graduation Report Picker"
{
    PageType = Card;
    SourceTable = 66610;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Graduation Academic Year"; Rec."Graduation Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ClassificationList)
            {
                Caption = 'Classification List';
                Image = Agreement;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    YoSInt: Integer;
                    ACAClassificationHeader: Record "ACA-Classification Header";
                    FinalSenateClassificationz: Report 66611;
                begin
                    Rec.TESTFIELD("Graduation Academic Year");
                    Rec.TESTFIELD(Programme);
                    ACACourseRegistration.RESET;
                    ACAClassificationHeader.RESET;
                    IF Rec."Graduation Academic Year" <> '' THEN BEGIN
                        ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                        ACACourseRegistration.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    END;
                    IF Rec.Programme <> '' THEN BEGIN
                        ACACourseRegistration.SETRANGE(Programmes, Rec.Programme);
                        ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                        ACAProgrammeStages.RESET;
                        ACAProgrammeStages.SETRANGE("Programme Code", Rec.Programme);
                        ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
                        IF ACAProgrammeStages.FIND('+') THEN BEGIN
                            CLEAR(YoSInt);
                            IF EVALUATE(YoSInt, COPYSTR(ACAProgrammeStages.Code, 2, 1)) THEN BEGIN
                                ACAClassificationHeader.SETRANGE("Year of Study", YoSInt);
                                ACACourseRegistration.SETRANGE("Year Of Study", YoSInt);
                            END;
                        END;
                    END;
                    IF ACACourseRegistration.FIND('-') THEN;
                    IF ACAClassificationHeader.FIND('-') THEN;
                    CLEAR(YoSComputed);
                    Prog.RESET;
                    Prog.SETRANGE(Code, Rec.Programme);
                    IF Prog.FIND('-') THEN BEGIN
                        ACAProgrammeStages.RESET;
                        ACAProgrammeStages.SETRANGE("Programme Code", Prog.Code);
                        ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
                        IF ACAProgrammeStages.FIND('-') THEN BEGIN
                            IF ((COPYSTR(ACAProgrammeStages.Code, 2, 1)) IN ['1', '2', '3', '4', '5', '6', '7']) THEN
                                EVALUATE(YoSComputed, COPYSTR(ACAProgrammeStages.Code, 2, 1))
                            ELSE
                                ERROR('Final Stage of study has an invalid format!');
                        END ELSE
                            ERROR('Programme last stage is not defined!');
                    END ELSE
                        ERROR('Programme not Found!');

                    ACAClassificationHeader.RESET;
                    ACAClassificationHeader.SETRANGE("User ID", USERID);
                    ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    IF ACAClassificationHeader.FIND('-') THEN ACAClassificationHeader.DELETEALL;
                    ACAClassificationDetails.RESET;
                    ACAClassificationDetails.SETRANGE("User ID", USERID);
                    ACAClassificationDetails.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationDetails.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    IF ACAClassificationDetails.FIND('-') THEN ACAClassificationDetails.DELETEALL;
                    ACAClassGradRubrics.RESET;
                    IF ACAClassGradRubrics.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ACAClassificationHeader.INIT;
                            ACAClassificationHeader."User ID" := USERID;
                            ACAClassificationHeader."Graduation Academic Year" := Rec."Graduation Academic Year";
                            ACAClassificationHeader."Classification Code" := ACAClassGradRubrics.Code;
                            ACAClassificationHeader."Classification Order" := ACAClassGradRubrics."Order No";
                            ACAClassificationHeader."Programme Code" := Rec.Programme;
                            IF ACAClassGradRubrics.Code = 'INCOMPLETE' THEN BEGIN
                                ACAClassificationHeader."Pass Status" := 'INCOMPLETE';
                                ACAClassificationHeader."Pass Status Order" := 2;
                            END ELSE BEGIN
                                ACAClassificationHeader."Pass Status" := 'PASS';
                                ACAClassificationHeader."Pass Status Order" := 1;
                            END;
                            ACAClassificationHeader."Year of Study" := YoSComputed;
                            ACAClassificationHeader."Year of Study Text" := GetYearofStudyText(YoSComputed);
                            ACAClassificationHeader.Msg1 := ACAClassGradRubrics."Classification Msg1";
                            ACAClassificationHeader.Msg2 := ACAClassGradRubrics."Classification Msg2";
                            ACAClassificationHeader.Msg3 := ACAClassGradRubrics."Classification Msg3";
                            ACAClassificationHeader.Msg4 := ACAClassGradRubrics."Classification Msg4";
                            ACAClassificationHeader.Msg5 := ACAClassGradRubrics."Classification Msg5";
                            ACAClassificationHeader.Msg6 := ACAClassGradRubrics."Classification Msg6";
                            ACAClassificationHeader."Final Year Comment" := ACAClassGradRubrics."Final Year Comment";
                            ACAClassificationHeader.INSERT;
                        END;
                        UNTIL ACAClassGradRubrics.NEXT = 0;
                    END;
                    CLEAR(ITmCourseReg);
                    ITmCourseReg.RESET;
                    ITmCourseReg.SETFILTER(Status, '%1|%2|%3', ITmCourseReg.Status::Current, ITmCourseReg.Status::Registration, ITmCourseReg.Status::Deceased);
                    ITmCourseReg.SETRANGE(Programmes, Rec.Programme);
                    ITmCourseReg.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    ITmCourseReg.SETRANGE(ITmCourseReg.Reversed, FALSE);
                    ITmCourseReg.SETRANGE(ITmCourseReg."Year Of Study", YoSComputed);
                    // ITmCourseReg.COPYFILTERS(ACACourseRegistration);
                    IF ITmCourseReg.FIND('-') THEN BEGIN
                        // // // // // IF ACACourseRegistration.FIND('-') THEN BEGIN
                        // // // // //    REPORT.RUN(66610,FALSE,FALSE,ACACourseRegistration);
                        // // // // //  END;
                        //// Update Graduation Parameters
                        REPEAT
                        BEGIN
                            // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Special Exam Exists");
                            // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Passed Units",ITmCourseReg."Supp. Yearly Failed Units");
                            // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Total Units Taken",ITmCourseReg."Is Final Year Student",
                            // // // ITmCourseReg."Graduation Status Count");
                            //////////////////..........................................................................

                            ACAClassificationHeader.RESET;
                            ACAClassificationHeader.SETRANGE("User ID", USERID);
                            ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                            ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                            ACAClassificationHeader.SETRANGE("Classification Code", ITmCourseReg."Final Clasification");
                            IF ACAClassificationHeader.FIND('-') THEN;
                            IF Cust.GET(ITmCourseReg."Student No.") THEN;

                            ACAClassificationDetails.RESET;
                            ACAClassificationDetails.SETRANGE("User ID", USERID);
                            ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.Programmes);
                            ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg."Graduation Academic Year");
                            ACAClassificationDetails.SETRANGE("Student No.", ITmCourseReg."Student No.");
                            IF NOT ACAClassificationDetails.FIND('-') THEN BEGIN

                                ACAClassificationDetails.INIT;
                                ACAClassificationDetails."User ID" := USERID;
                                ACAClassificationDetails."Graduation Academic Year" := ITmCourseReg."Graduation Academic Year";
                                ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                                ACAClassificationDetails."Programme Code" := ITmCourseReg.Programmes;
                                ACAClassificationDetails."Student No." := ITmCourseReg."Student No.";
                                ACAClassificationDetails."Student Name" := Cust.Name;
                                IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                                    ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                                END ELSE BEGIN
                                    ACAClassificationDetails."Pass Status" := 'PASS';
                                END;
                                ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                                ACAClassificationDetails."Class Order" := ACAClassificationHeader."Classification Order";
                                ACAClassificationDetails.INSERT;
                            END ELSE BEGIN
                                ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                                IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                                    ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                                END ELSE BEGIN
                                    ACAClassificationDetails."Pass Status" := 'PASS';
                                END;
                                ACAClassificationDetails."Student Name" := Cust.Name;
                                ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                                ACAClassificationDetails."Class Order" := ACAClassificationHeader."Classification Order";
                                ACAClassificationDetails.MODIFY;
                            END;
                        END;
                        UNTIL ITmCourseReg.NEXT = 0;
                    END;
                    //Update Serials

                    CLEAR(incounts);
                    ACAClassificationDetails.RESET;
                    ACAClassificationDetails.SETRANGE("User ID", USERID);
                    ACAClassificationDetails.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationDetails.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    ACAClassificationDetails.SETRANGE("Pass Status", 'PASS');
                    ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student Name", ACAClassificationDetails."Pass Status",
                    ACAClassificationDetails."Classification Code", ACAClassificationDetails."Class Order");
                    IF ACAClassificationDetails.FIND('-') THEN BEGIN
                        CLEAR(incounts);
                        REPEAT
                        BEGIN
                            incounts += 1;
                            ACAClassificationDetails."Graduation Serial" := incounts;
                            ACAClassificationDetails.MODIFY;
                        END;
                        UNTIL ACAClassificationDetails.NEXT = 0;
                    END;

                    ACAClassificationHeader.RESET;
                    ACAClassificationHeader.SETRANGE("User ID", USERID);
                    ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    IF ACAClassificationHeader.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN//Updating Graduation Numbering
                             /// Update Classification Numbering
                            CLEAR(incounts);
                            ACAClassificationDetails.RESET;
                            ACAClassificationDetails.SETRANGE("User ID", USERID);
                            ACAClassificationDetails.SETRANGE("Programme Code", Rec.Programme);
                            ACAClassificationDetails.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                            ACAClassificationDetails.SETRANGE("Classification Code", ACAClassificationHeader."Classification Code");
                            ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student No.", ACAClassificationDetails."Classification Code");
                            IF ACAClassificationDetails.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    incounts += 1;
                                    ACAClassificationDetails."Classification Serial" := incounts;
                                    ACAClassificationDetails.MODIFY;
                                END;
                                UNTIL ACAClassificationDetails.NEXT = 0;
                            END;

                        END;
                        UNTIL ACAClassificationHeader.NEXT = 0;
                    END;
                    ACAClassificationHeader.RESET;
                    ACAClassificationHeader.SETRANGE("User ID", USERID);
                    ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");

                    IF ACAClassificationHeader.FIND('-') THEN BEGIN
                        REPORT.RUNMODAL(66611, FALSE, FALSE, ACAClassificationHeader);
                    END;
                end;
            }
            action("Graduation List")
            {
                Caption = 'Graduation List';
                Image = Agreement;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    YoSInt: Integer;
                    ACAClassificationHeader: Record "ACA-Classification Header";
                    FinalSenateClassificationz: Report 66611;
                    FinalGraduationList: Report 66612;
                begin
                    Rec.TESTFIELD("Graduation Academic Year");
                    Rec.TESTFIELD(Programme);
                    ACACourseRegistration.RESET;
                    ACAClassificationHeader.RESET;
                    IF Rec."Graduation Academic Year" <> '' THEN BEGIN
                        ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                        ACACourseRegistration.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    END;
                    IF Rec.Programme <> '' THEN BEGIN
                        ACACourseRegistration.SETRANGE(Programmes, Rec.Programme);
                        ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                        ACAProgrammeStages.RESET;
                        ACAProgrammeStages.SETRANGE("Programme Code", Rec.Programme);
                        ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
                        IF ACAProgrammeStages.FIND('+') THEN BEGIN
                            CLEAR(YoSInt);
                            IF EVALUATE(YoSInt, COPYSTR(ACAProgrammeStages.Code, 2, 1)) THEN BEGIN
                                ACAClassificationHeader.SETRANGE("Year of Study", YoSInt);
                                ACACourseRegistration.SETRANGE("Year Of Study", YoSInt);
                            END;
                        END;
                    END;
                    IF ACACourseRegistration.FIND('-') THEN;
                    IF ACAClassificationHeader.FIND('-') THEN;
                    CLEAR(YoSComputed);
                    Prog.RESET;
                    Prog.SETRANGE(Code, Rec.Programme);
                    IF Prog.FIND('-') THEN BEGIN
                        ACAProgrammeStages.RESET;
                        ACAProgrammeStages.SETRANGE("Programme Code", Prog.Code);
                        ACAProgrammeStages.SETRANGE("Final Stage", TRUE);
                        IF ACAProgrammeStages.FIND('-') THEN BEGIN
                            IF ((COPYSTR(ACAProgrammeStages.Code, 2, 1)) IN ['1', '2', '3', '4', '5', '6', '7']) THEN
                                EVALUATE(YoSComputed, COPYSTR(ACAProgrammeStages.Code, 2, 1))
                            ELSE
                                ERROR('Final Stage of study has an invalid format!');
                        END ELSE
                            ERROR('Programme last stage is not defined!');
                    END ELSE
                        ERROR('Programme not Found!');

                    ACAClassificationHeader.RESET;
                    ACAClassificationHeader.SETRANGE("User ID", USERID);
                    ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    IF ACAClassificationHeader.FIND('-') THEN ACAClassificationHeader.DELETEALL;
                    ACAClassificationDetails.RESET;
                    ACAClassificationDetails.SETRANGE("User ID", USERID);
                    ACAClassificationDetails.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationDetails.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    IF ACAClassificationDetails.FIND('-') THEN ACAClassificationDetails.DELETEALL;
                    ACAClassGradRubrics.RESET;
                    IF ACAClassGradRubrics.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            ACAClassificationHeader.INIT;
                            ACAClassificationHeader."User ID" := USERID;
                            ACAClassificationHeader."Graduation Academic Year" := Rec."Graduation Academic Year";
                            ACAClassificationHeader."Classification Code" := ACAClassGradRubrics.Code;
                            ACAClassificationHeader."Classification Order" := ACAClassGradRubrics."Order No";
                            ACAClassificationHeader."Programme Code" := Rec.Programme;
                            IF ACAClassGradRubrics.Code = 'INCOMPLETE' THEN BEGIN
                                ACAClassificationHeader."Pass Status" := 'INCOMPLETE';
                                ACAClassificationHeader."Pass Status Order" := 2;
                            END ELSE BEGIN
                                ACAClassificationHeader."Pass Status" := 'PASS';
                                ACAClassificationHeader."Pass Status Order" := 1;
                            END;
                            ACAClassificationHeader."Year of Study" := YoSComputed;
                            ACAClassificationHeader."Year of Study Text" := GetYearofStudyText(YoSComputed);
                            ACAClassificationHeader.Msg1 := ACAClassGradRubrics."Classification Msg1";
                            ACAClassificationHeader.Msg2 := ACAClassGradRubrics."Classification Msg2";
                            ACAClassificationHeader.Msg3 := ACAClassGradRubrics."Classification Msg3";
                            ACAClassificationHeader.Msg4 := ACAClassGradRubrics."Classification Msg4";
                            ACAClassificationHeader.Msg5 := ACAClassGradRubrics."Classification Msg5";
                            ACAClassificationHeader.Msg6 := ACAClassGradRubrics."Classification Msg6";
                            ACAClassificationHeader."Final Year Comment" := ACAClassGradRubrics."Final Year Comment";
                            ACAClassificationHeader.INSERT;
                        END;
                        UNTIL ACAClassGradRubrics.NEXT = 0;
                    END;
                    CLEAR(ITmCourseReg);
                    ITmCourseReg.RESET;
                    ITmCourseReg.SETFILTER(Status, '%1|%2|%3', ITmCourseReg.Status::Current, ITmCourseReg.Status::Registration, ITmCourseReg.Status::Deceased);
                    ITmCourseReg.SETRANGE(Programmes, Rec.Programme);
                    ITmCourseReg.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    ITmCourseReg.SETRANGE(ITmCourseReg.Reversed, FALSE);
                    ITmCourseReg.SETRANGE(ITmCourseReg."Year Of Study", YoSComputed);
                    // ITmCourseReg.COPYFILTERS(ACACourseRegistration);
                    IF ITmCourseReg.FIND('-') THEN BEGIN
                        // // // // // IF ACACourseRegistration.FIND('-') THEN BEGIN
                        // // // // //    REPORT.RUN(66610,FALSE,FALSE,ACACourseRegistration);
                        // // // // //  END;
                        //// Update Graduation Parameters
                        REPEAT
                        BEGIN
                            // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Special Exam Exists");
                            // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Passed Units",ITmCourseReg."Supp. Yearly Failed Units");
                            // // // ITmCourseReg.CALCFIELDS(ITmCourseReg."Supp. Yearly Total Units Taken",ITmCourseReg."Is Final Year Student",
                            // // // ITmCourseReg."Graduation Status Count");
                            //////////////////..........................................................................

                            ACAClassificationHeader.RESET;
                            ACAClassificationHeader.SETRANGE("User ID", USERID);
                            ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                            ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                            ACAClassificationHeader.SETRANGE("Classification Code", ITmCourseReg."Final Clasification");
                            IF ACAClassificationHeader.FIND('-') THEN;
                            IF Cust.GET(ITmCourseReg."Student No.") THEN;

                            ACAClassificationDetails.RESET;
                            ACAClassificationDetails.SETRANGE("User ID", USERID);
                            ACAClassificationDetails.SETRANGE("Programme Code", ITmCourseReg.Programmes);
                            ACAClassificationDetails.SETRANGE("Graduation Academic Year", ITmCourseReg."Graduation Academic Year");
                            ACAClassificationDetails.SETRANGE("Student No.", ITmCourseReg."Student No.");
                            IF NOT ACAClassificationDetails.FIND('-') THEN BEGIN

                                ACAClassificationDetails.INIT;
                                ACAClassificationDetails."User ID" := USERID;
                                ACAClassificationDetails."Graduation Academic Year" := ITmCourseReg."Graduation Academic Year";
                                ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                                ACAClassificationDetails."Programme Code" := ITmCourseReg.Programmes;
                                ACAClassificationDetails."Student No." := ITmCourseReg."Student No.";
                                ACAClassificationDetails."Student Name" := Cust.Name;
                                IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                                    ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                                END ELSE BEGIN
                                    ACAClassificationDetails."Pass Status" := 'PASS';
                                END;
                                ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                                ACAClassificationDetails."Class Order" := ACAClassificationHeader."Classification Order";
                                ACAClassificationDetails.INSERT;
                            END ELSE BEGIN
                                ACAClassificationDetails."Classification Code" := ITmCourseReg."Final Clasification";
                                IF ITmCourseReg."Final Clasification" = 'INCOMPLETE' THEN BEGIN
                                    ACAClassificationDetails."Pass Status" := 'INCOMPLETE';
                                END ELSE BEGIN
                                    ACAClassificationDetails."Pass Status" := 'PASS';
                                END;
                                ACAClassificationDetails."Student Name" := Cust.Name;
                                ACAClassificationDetails."Year of Study" := ITmCourseReg."Year Of Study";
                                ACAClassificationDetails."Class Order" := ACAClassificationHeader."Classification Order";
                                ACAClassificationDetails.MODIFY;
                            END;
                        END;
                        UNTIL ITmCourseReg.NEXT = 0;
                    END;
                    //Update Serials

                    CLEAR(incounts);
                    ACAClassificationDetails.RESET;
                    ACAClassificationDetails.SETRANGE("User ID", USERID);
                    ACAClassificationDetails.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationDetails.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    ACAClassificationDetails.SETRANGE("Pass Status", 'PASS');
                    ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student Name", ACAClassificationDetails."Pass Status",
                    ACAClassificationDetails."Classification Code", ACAClassificationDetails."Class Order");
                    IF ACAClassificationDetails.FIND('-') THEN BEGIN
                        CLEAR(incounts);
                        REPEAT
                        BEGIN
                            incounts += 1;
                            ACAClassificationDetails."Graduation Serial" := incounts;
                            ACAClassificationDetails.MODIFY;
                        END;
                        UNTIL ACAClassificationDetails.NEXT = 0;
                    END;

                    ACAClassificationHeader.RESET;
                    ACAClassificationHeader.SETRANGE("User ID", USERID);
                    ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                    IF ACAClassificationHeader.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN//Updating Graduation Numbering
                             /// Update Classification Numbering
                            CLEAR(incounts);
                            ACAClassificationDetails.RESET;
                            ACAClassificationDetails.SETRANGE("User ID", USERID);
                            ACAClassificationDetails.SETRANGE("Programme Code", Rec.Programme);
                            ACAClassificationDetails.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");
                            ACAClassificationDetails.SETRANGE("Classification Code", ACAClassificationHeader."Classification Code");
                            ACAClassificationDetails.SETCURRENTKEY(ACAClassificationDetails."Student No.", ACAClassificationDetails."Classification Code");
                            IF ACAClassificationDetails.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    incounts += 1;
                                    ACAClassificationDetails."Classification Serial" := incounts;
                                    ACAClassificationDetails.MODIFY;
                                END;
                                UNTIL ACAClassificationDetails.NEXT = 0;
                            END;

                        END;
                        UNTIL ACAClassificationHeader.NEXT = 0;
                    END;
                    ACAClassificationHeader.RESET;
                    ACAClassificationHeader.SETRANGE("User ID", USERID);
                    ACAClassificationHeader.SETRANGE("Programme Code", Rec.Programme);
                    ACAClassificationHeader.SETRANGE("Graduation Academic Year", Rec."Graduation Academic Year");

                    IF ACAClassificationHeader.FIND('-') THEN BEGIN
                        // //    FinalGraduationList.SETTABLEVIEW(ACAClassificationHeader);
                        // //    FinalGraduationList.RUNMODAL;//
                        REPORT.RUNMODAL(66612, FALSE, FALSE, ACAClassificationHeader);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("User ID", USERID);
    end;

    trigger OnOpenPage()
    begin
        ACAGraduationReportPicker.RESET;
        ACAGraduationReportPicker.SETRANGE("User ID", USERID);
        IF NOT ACAGraduationReportPicker.FIND('-') THEN BEGIN
            ACAGraduationReportPicker.INIT;
            ACAGraduationReportPicker."User ID" := USERID;
            ACAGraduationReportPicker.INSERT;
        END;
    end;

    var
        ACAGraduationReportPicker: Record "ACA-Graduation Report Picker";
        GradAcdYear: Code[1024];
        YearOfStudy: Option " ","1","2","3","4","5","6","7";
        ProgFilters: Code[1024];
        ACACourseRegistration: Record "ACA-Course Registration";
        ITmCourseReg: Record "ACA-Course Registration";
        ACAProgramme: Record "ACA-Programme";
        ACAProgrammeStages: Record "ACA-Programme Stages";
        YoSComputed: Integer;
        ACAClassificationHeader: Record "ACA-Classification Header";
        ACAClassificationDetails: Record "ACA-Classification Details";
        ACAClassificationDetails2: Record "ACA-Classification Details";
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        SpecialReason: Text[150];
        failExists: Boolean;
        StatusOrder: Integer;
        statusCompiled: Code[50];
        NotSpecialNotSuppSpecial: Boolean;
        isSpecialOnly: Boolean;
        IsSpecialAndSupp: Boolean;
        IsaForthYear: Boolean;
        IsSpecialUnit: Boolean;
        SpecialUnitReg1: Boolean;
        SpecialUnitReg: Boolean;
        ACASenateReportCounts: Record 77720;
        NoOfStudentInText: Text[250];
        ConvertDecimalToText: Codeunit "Convert Decimal To Text ACA";
        PercentageFailedCaption: Text[100];
        NumberOfCoursesFailedCaption: Text[100];
        PercentageFailedValue: Decimal;
        NoOfCausesFailedValue: Integer;
        NoOfStudentsDecimal: Text;
        //ACAStudentUnits: Record "61549";
        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;
        //StudUnits: Record "61549";
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record Customer;
        // Semesters: Record "61692";
        //Dimensions: Record "349";
        Prog: Record "ACA-Programme";
        FacDesc: Code[100];
        //  Depts: Record "349";
        //Stages: Record "61516";
        StudentsL: Text[250];
        N: Integer;
        Grd: Code[20];
        Marks: Decimal;
        // Dimensions2: Record "349";
        /*  ResultsStatus: Record "78011";
         ResultsStatus3: Record "78011";
         UnitsRec: Record "61517"; */
        UnitsDesc: Text[100];
        UnitsHeader: Text[50];
        FailsDesc: Text[200];
        Nx: Integer;
        RegNo: Code[20];
        Names: Text[100];
        Ucount: Integer;
        RegNox: Code[20];
        Namesx: Text[100];
        Nxx: Text[30];
        SemYear: Code[20];
        ShowSem: Boolean;
        SemDesc: Code[100];
        /* CREG2: Record "61532";
        ExamsProcessing: Codeunit "60110";
        CompInf: Record "79";
 */
        YearDesc: Text[30];
        MaxYear: Code[20];
        MaxSem: Code[20];
        CummScore: Decimal;
        CurrScore: Decimal;
        mDate: Date;
        /*  IntakeRec: Record "61383";
  */
        IntakeDesc: Text[100];
        SemFilter: Text[100];
        StageFilter: Text[100];
        MinYear: Code[20];
        MinSem: Code[20];
        StatusNarrations: Text[1000];
        NextYear: Code[20];
        facCode: Code[20];
        progName: Code[150];
        //ACAResultsStatus: Record "78011";
        Msg1: Text[250];
        Msg2: Text[250];
        Msg3: Text[250];
        Msg4: Text[250];
        Msg5: Text[250];
        Msg6: Text[250];
        YearOfStudyText: Text[30];
        SaltedExamStatus: Code[1024];
        SaltedExamStatusDesc: Text;
        /* ACASenateReportStatusBuff: Record "77718" temporary;
        CurrNo: Integer;
        YoS: Code[20];
        CReg33: Record "61532";
        CReg: Record "61532";
        yosInt: Integer;
        ACAUnitsSubjects: Record "61517"; */
        incounts: Integer;

    local procedure GetYearofStudyText(Yos: Integer) YosText: Text[150]
    begin
        CLEAR(YosText);
        IF Yos = 1 THEN YosText := 'FIRST';
        IF Yos = 2 THEN YosText := 'SECOND';
        IF Yos = 3 THEN YosText := 'THIRD';
        IF Yos = 4 THEN YosText := 'FORTH';
        IF Yos = 5 THEN YosText := 'FIFTH';
        IF Yos = 6 THEN YosText := 'SIXTH';
        IF Yos = 7 THEN YosText := 'SEVENTH';
    end;
}

