report 66671 "AcaProcess Results Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/AcaProcess Results Status.rdl';

    dataset
    {
        dataitem(BufferStatus; "Provisional Transcript Comment")
        {
            dataitem(StatusList; "ACA-Results Status")
            {
                DataItemLink = Code = FIELD(Code),
                               "Special Programme Class" = FIELD("Special Programme Class");

                trigger OnAfterGetRecord()
                begin
                    StatusList."1st Year Trans. Comments" := BufferStatus."1st Year Trans. Comments";
                    StatusList."2nd Year  Trans. Comments" := BufferStatus."2nd Year  Trans. Comments";
                    StatusList."3rd Year  Trans. Comments" := BufferStatus."3rd Year  Trans. Comments";
                    StatusList."4th Year  Trans. Comments" := BufferStatus."4th Year  Trans. Comments";
                    StatusList."5th Year  Trans. Comments" := BufferStatus."5th Year  Trans. Comments";
                    StatusList."6th Year  Trans. Comments" := BufferStatus."6th Year  Trans. Comments";
                    StatusList."7th Year  Trans. Comments" := BufferStatus."7th Year  Trans. Comments";
                    StatusList.MODIFY;
                end;
            }
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
}

