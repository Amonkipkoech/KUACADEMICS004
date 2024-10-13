
dotnet
{
    assembly("")
    {
        type(""; "BC")
        {
        }
    }

    // assembly("BiostarIntegration")
    // {

    //     type("BiostarIntegration".Auth; Biostar)
    //     {
    //     }
    // }
    // assembly(biostar)
    // {
    //     type("Web_API_Test".Program; BiostarIntegration)
    //     {

    //     }

    // }

    assembly("mscorlib")
    {
        Version = '2.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.IO.Directory"; "BCDirectory")
        {
        }

        type("System.IO.SearchOption"; "BCSearchOption")
        {
        }
    }



    /*assembly("DocumentsManagement")
    {
        Version = '1.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '9eb2a50b68df895f';

        type("DocumentManagement.DocumentManagement"; "BCDocumentManagement")
        {
            IsControlAddIn = true;
        }


    }
    assembly("Microsoft.Dynamics.Nav.Client.DragDrop")
    {
        Version = '1.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '792726a4b96f39a7';

        type("Microsoft.Dynamics.Nav.Client.DragDrop.IDragDropAddIn"; "DragDropAddIn")
        {
            IsControlAddIn = true;
        }

    }*/

    assembly(mscorlib)
    {
        type(System.IO.Directory; MyDirectory) { }
        type("System.IO.MemoryStream"; BCMemoryStream)
        {
        }

        type("System.IO.Stream"; BCStream)
        {
        }
        type("System.IO.FileStream"; BCFileStream)
        {
        }
        type("System.Array"; DotNetArray)
        {
        }
        type("System.Convert"; BCConvert)
        {
        }

        type("System.String"; FileLink)
        {

        }
        type("System.IO.File"; FileContent)
        {
        }
        type("System.String"; DotnetString)
        {
        }
        type("System.Object"; Object)
        {

        }
        // type("system.Reflection.PropertyInfo"; Reflection)
        // {

        // }
        //    type("system.Array")
        // {

        // }

    }

    // assembly("System.Net.Http")
    // {
    //     type("System.Net.Http.StringContent"; Http)
    //     {
    //     }
    // }
    // assembly(System)
    // {
    //     Version = '4.0.0.0';
    //     Culture = 'neutral';
    //     PublicKeyToken = 'b77a5c561934e089';

    //     type("System.Text.RegularExpressions.Regex"; BCRegex)
    //     {
    //     }
    //     type("System.Text.RegularExpressions.Match"; BCMatch)
    //     {
    //     }
    //     //   type("system.Reflection.PropertyInfo";PI)
    //     // {

    //     // }

    //     // type("System.Net.NetworkCredential"; NetworkCredential)
    //     // {
    //     // }
    // }

    // assembly("Microsoft.SharePoint.Client")
    // {
    //     Version = '16.1.0.0';
    //     Culture = 'neutral';
    //     PublicKeyToken = '71e9bce111e9429c';

    //     type("Microsoft.SharePoint.Client.ClientContext"; ClientContext)
    //     {
    //     }
    //     type("Microsoft.SharePoint.Client.FileCreationInformation"; FileCreationInformation)
    //     {
    //     }
    //     type("Microsoft.SharePoint.Client.List"; MyList)
    //     {
    //     }
    //     type("Microsoft.SharePoint.Client.Web"; Web)
    //     {
    //     }
    //     type("Microsoft.SharePoint.Client.Folder"; FolderName)
    //     {
    //     }
    //     type("Microsoft.SharePoint.Client.File"; SharepointFile)
    //     {
    //     }
    // }
    // assembly(SharepointCustomLibrary)
    // {
    //     Version = '1.0.0.0';
    //     Culture = 'neutral';
    //     PublicKeyToken = '';
    //     type("SharePointFileUploader.SharePointUploader"; Sharepoint)
    //     {

    //     }
    // }



}
