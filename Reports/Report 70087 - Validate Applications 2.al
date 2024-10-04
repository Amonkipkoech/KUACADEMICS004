report 70087 "Validate Applications 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("KUCCPS Imports"; 70082)
        {

            trigger OnAfterGetRecord()
            begin

                Customer.RESET;
                Customer.SETRANGE("No.", "KUCCPS Imports".Admin);
                //Customer.SETFILTER("Date Registered",'=%1',TODAY);
                IF Customer.FIND('-') THEN BEGIN
                    IF "KUCCPS Imports".Gender = "KUCCPS Imports".Gender::Female THEN BEGIN
                        Customer.Gender := Customer.Gender::Female;
                    END ELSE BEGIN
                        Customer.Gender := Customer.Gender::Male;
                    END;
                    Customer.MODIFY;
                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE("Student No.", "KUCCPS Imports".Admin);
                    // CourseRegistration.SETRANGE(Programme,"KUCCPS Imports".Prog);
                    // CourseRegistration.SETRANGE(Semester,"KUCCPS Imports".Semester);
                    IF CourseRegistration.FIND('-') THEN BEGIN
                        CourseRegistration.Gender := "KUCCPS Imports".Gender;
                        CourseRegistration.MODIFY;

                    END;
                END;
                /*
                 IF "ACA-Applic. Form Header"."Admitted Degree"<>'P109' THEN BEGIN
                  Customer.RESET;
                  Customer.SETRANGE("No.","ACA-Applic. Form Header"."Admission No");
                  Customer.SETFILTER("Date Registered",'=%1',TODAY);
                  IF Customer.FIND('-') THEN BEGIN
                  CourseRegistration.RESET;
                  CourseRegistration.SETRANGE("Student No.","ACA-Applic. Form Header"."Admission No");
                  CourseRegistration.SETRANGE("Settlement Type","ACA-Applic. Form Header"."Settlement Type");
                  CourseRegistration.SETRANGE(Programme,"ACA-Applic. Form Header"."First Degree Choice");
                  CourseRegistration.SETRANGE(Semester,"ACA-Applic. Form Header"."Admitted Semester");
                  IF NOT CourseRegistration.FIND('-') THEN BEGIN
                            CourseRegistration.INIT;
                               CourseRegistration."Reg. Transacton ID":='';
                               CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                               CourseRegistration."Student No.":="ACA-Applic. Form Header"."Admission No";
                               CourseRegistration.Programme:="ACA-Applic. Form Header"."Admitted Degree";
                               CourseRegistration.Gender:=Customer.Gender;
                               CourseRegistration.Semester:="ACA-Applic. Form Header"."Admitted Semester";
                               CourseRegistration.Stage:="ACA-Applic. Form Header"."Admitted To Stage";
                               CourseRegistration."Student Type":=CourseRegistration."Student Type"::"Full Time";
                               CourseRegistration."Registration Date":=TODAY;
                               CourseRegistration."Settlement Type":="ACA-Applic. Form Header"."Settlement Type";
                               CourseRegistration."Academic Year":=GetCurrYear();
                               //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                            CourseRegistration.INSERT;
                  CourseRegistration.RESET;
                  CourseRegistration.SETRANGE("Student No.","ACA-Applic. Form Header"."Admission No");
                  CourseRegistration.SETRANGE("Settlement Type","ACA-Applic. Form Header"."Settlement Type");
                  CourseRegistration.SETRANGE(Programme,"ACA-Applic. Form Header"."First Degree Choice");
                  CourseRegistration.SETRANGE(Semester,"ACA-Applic. Form Header"."Admitted Semester");
                  IF  CourseRegistration.FIND('-') THEN BEGIN
                            CourseRegistration."Settlement Type":="ACA-Applic. Form Header"."Settlement Type";
                            CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                            CourseRegistration."Academic Year":=GetCurrYear();
                               CourseRegistration.Gender:=Customer.Gender;
                            CourseRegistration."Registration Date":=TODAY;
                            CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                            CourseRegistration.MODIFY;
                
                            END;
                            END ELSE BEGIN
                                CourseRegistration.RESET;
                  CourseRegistration.SETRANGE("Student No.","ACA-Applic. Form Header"."Admission No");
                  CourseRegistration.SETRANGE("Settlement Type","ACA-Applic. Form Header"."Settlement Type");
                  CourseRegistration.SETRANGE(Programme,"ACA-Applic. Form Header"."First Degree Choice");
                  CourseRegistration.SETRANGE(Semester,"ACA-Applic. Form Header"."Admitted Semester");
                  CourseRegistration.SETFILTER(Posted,'=%1',FALSE);
                  IF  CourseRegistration.FIND('-') THEN BEGIN
                            CourseRegistration."Settlement Type":="ACA-Applic. Form Header"."Settlement Type";
                            CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                            CourseRegistration."Academic Year":=GetCurrYear();
                               CourseRegistration.Gender:=Customer.Gender;
                            CourseRegistration."Registration Date":=TODAY;
                            CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                            CourseRegistration.MODIFY;
                
                            END;
                              END;
                            END;
                            END;
                */

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
        CourseRegistration: Record 61532;
        Customer: Record 18;
}

