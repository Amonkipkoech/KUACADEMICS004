report 51473 "Copy Fees Structure"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Copy Fees Structure.rdl';

    dataset
    {
        dataitem("ACA-Fee By Stage"; "ACA-Fee By Stage")
        {
            RequestFilterFields = "Copy From Programme", "Copy To Programme", "Copy From Semester", "Copy To Semester";

            trigger OnAfterGetRecord()
            begin

                FS.RESET;
                FS.SETRANGE(FS.Semester, "ACA-Fee By Stage".Semester);
                FS.SETRANGE(FS."Programme Code", "ACA-Fee By Stage"."Programme Code");
                FS.SETRANGE(FS."Stage Code", "ACA-Fee By Stage"."Stage Code");
                //FS.SETRANGE(FS.Campus,"Fee By Stage".Campus) ;
                //FS.SETRANGE(FS."Student Type","Fee By Stage"."Student Type");

                IF FS.FIND('-') THEN BEGIN

                    FS1.RESET;
                    FS1.SETFILTER(FS1."Programme Code", GETFILTER("ACA-Fee By Stage"."Copy To Programme"));
                    FS1.SETRANGE(FS1."Stage Code", FS."Stage Code");
                    FS1.SETFILTER(FS1.Semester, "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Semester"));
                    // FS.SETRANGE(FS.Campus,"Fee By Stage".Campus) ;
                    // FS.SETRANGE(FS."Student Type","Fee By Stage"."Student Type");
                    // FS.SETRANGE(FS."Settlemet Type","Fee By Stage"."Settlemet Type");
                    IF NOT FS1.FIND('-') THEN BEGIN

                        REPEAT
                            FS2.INIT;
                            FS2."Programme Code" := "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Programme");
                            FS2."Stage Code" := FS."Stage Code";
                            FS2.Semester := "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Semester");
                            FS2."Student Type" := FS."Student Type";
                            FS2."Settlemet Type" := FS."Settlemet Type";
                            FS2."Seq." := "Seq.";
                            //FS2.Group:=FS.Group;
                            //FS2.Campus:=Campus;
                            FS2."Break Down" := FS."Break Down";
                            FS2.Remarks := FS.Remarks;
                            FS2."Amount Not Distributed" := FS."Amount Not Distributed";
                            FS2.INSERT;

                            SC1.RESET;
                            SC1.SETRANGE(SC1."Programme Code", "ACA-Fee By Stage"."Programme Code");
                            SC1.SETRANGE(SC1."Stage Code", "ACA-Fee By Stage"."Stage Code");
                            IF SC1.FIND('-') THEN BEGIN
                                REPEAT
                                    SC2.INIT;
                                    SC2."Programme Code" := "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Programme");
                                    SC2."Stage Code" := SC1."Stage Code";
                                    SC2.Code := SC1.Code;
                                    SC2."Settlement Type" := SC1."Settlement Type";
                                    SC2.Semester := SC1.Semester;
                                    SC2.Description := SC1.Description;
                                    SC2.Amount := SC1.Amount;
                                    SC2."Student Type" := SC1."Student Type";
                                    SC2.INSERT;
                                UNTIL SC1.NEXT = 0;
                            END;
                        UNTIL FS.NEXT = 0;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin

                IF "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy From Semester") = '' THEN
                    ERROR('You must select the Copy from semester');
                IF "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Semester") = '' THEN
                    ERROR('You must select the Copy To semester');
                IF "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy From Programme") = '' THEN
                    ERROR('You must select the Copy from Programme');
                IF "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Programme") = '' THEN
                    ERROR('You must select the Copy To Programme');

                SETFILTER("ACA-Fee By Stage"."Programme Code", "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy From Programme"));
                SETFILTER("ACA-Fee By Stage".Semester, "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy From Semester"));

                FS.RESET;
                FS.SETFILTER(FS.Semester, "ACA-Fee By Stage".GETFILTER("Copy To Semester"));
                FS.SETFILTER(FS."Programme Code", "ACA-Fee By Stage".GETFILTER("ACA-Fee By Stage"."Copy To Programme"));
                //FS.SETFILTER(FS."Stage Code","Fee By Stage".GETFILTER("Fee By Stage"."Stage Code"));

                IF FS.FIND('-') THEN ERROR('Semester ' + "ACA-Fee By Stage".GETFILTER("Copy To Semester") + ' Already Exist in the Fees Structure');
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
        FS: Record 61523;
        FS2: Record 61523;
        FS1: Record 61523;
        SC1: Record 61533;
        SC2: Record 61533;
}

