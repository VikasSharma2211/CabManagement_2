/// <reference path="../DataTable/dataTables.tableTools.js" />
$(document).ready(function () {

    $(function () {
        $("#accordion").accordion({
            collapsible: true
        });
    });

    $('#Reprint').click(function () {

        //$('.tablecss').css('display',none);


    });
    var roosterNumbers = [];//global variable

        $("#frmrostermanagement").validationEngine({
            // Auto-hide prompt
            autoHidePrompt: true,
            // Delay before auto-hide
            autoHideDelay: 2000,
            // Fade out duration while hiding the validations
            fadeDuration: 0.3
        });

 

    var fadeId = $('#pageloaddiv,#overlay-back');
    var btnSubmit = $("#btnSubmit");
    fadeId.fadeIn(500);

    //code to load active all Control list
    btnSubmit.hide();
    $("#aCheckErrorList").hide();
    fadeId.fadeOut(500);
    $("#fileuploader").uploadFile({
        url: "../Upload.ashx",
        allowedTypes: "xlsx",
        fileName: "myfile",
        showStatusAfterSuccess: false,
        showAbort: false,
        showDone: false,
        dragDrop: false,
        multiple: false,
        onSubmit: function (files) {

        },
        onSuccess: function (files, data, xhr) {

            btnSubmit.show();
        },
        onError: function (files, status, errMsg) {

            btnSubmit.hide();
        }

    });


});

function ValidateUploadedRoster() {
    var Insertresult = "";
    var commonRow = "";
    var roosterNumbers = "";
    $.ajax({
        type: "POST",
        url: "RoosterManagement.aspx/ValidateUploadedRoster",
        data: "{'rosterdetail':" + JSON.stringify('') + "}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var msg = result.d;
        
            var FadeId = $("#pageloaddiv, #overlay-back");
            var BtnSubmitId = $("#btnSubmit");
            if (msg == 'Valid') {        
                Insertresult = InsertRoasterDetail();
                roosterNumbers = Insertresult[0];
                commonRow = Insertresult[2];
             
                if (Insertresult[1] == false)
                {

                    $('.XLError').html("<b>Duplicate Records with same employee id and shift cant be inserted</b>").css({ 'color': 'red' });

                    $('.RoosterPdf').css({ 'display': 'none' });

                }
                   
                FadeId.fadeIn(500);
                GetInavlidMappedRecord(roosterNumbers, commonRow);
                BtnSubmitId.hide();
                FadeId.fadeOut(500);

            }
            else if (msg == 'PartialValid') {
                FadeId.fadeIn(500);
                GetInavlidMappedRecord(roosterNumbers, commonRow);
                BtnSubmitId.hide();
                FadeId.fadeOut(500);
             
            }
            else {

                GetInavlidMappedRecord(roosterNumbers, commonRow);
                BtnSubmitId.hide();
             
            }
        },
        error: function (er) {
            alert(er);
        }
    });
}



function GetInavlidMappedRecord(roosterNumbers, commonRow) {
 
    roosterNumbers = roosterNumbers;
    var validgender = "";
    var validcontact = false;
    var validdate = false;
    var validtime = false;
    validaddress = false;
    $.ajax({
        type: "POST",
        url: "RoosterManagement.aspx/GetInvalidData",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var listrecord = result.d;
            if (listrecord == null)
                listrecord = [];
    $('#tblLstrosterunmapped').dataTable({
          
                "dom": 'T<"clear">lfrtip',
                "tableTools": {
     
                    "aButtons": [              
                {
                    "sExtends": "print",
                    "sMessage": "Rooster Number" + roosterNumbers,
                    "sButtonClass": "print_class"
                },
                     {
                         "sExtends": "pdf",
                         "sButtonText": "Copy to pdf",
                         "sMessage": "Rooster Number" + roosterNumbers,
                         "mColumns": [5, 6, 7, 9, 2, 13, 12, 14, 0, 15,16],
                         "sFileName": roosterNumbers + " - *.pdf",
                         "sPdfOrientation": "landscape",
                         "sTitle": "Rooster Sheet",
                         "oSelectorOpts": { filter: 'applied', order: 'current' }

                         }
                            
                    ],
                 
                    "sSwfPath": "../Media/swf/copy_csv_xls_pdf.swf"
                },
                destroy: true,
                paging: true,
                bSortClasses: false,
                "scrollX": true,
                "bStateSave": true,
                "data": listrecord,
                "aoColumns":
                    [
                    {
                        "data": "Cabno", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.CabPropertyValid, data);

                        }
                    },
                    {
                        "data": "CabCapacity", "bSortable": false, "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.CabCapacityValid, data);

                        }
                    },
                    {
                        "data": "RouteName", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.RouteNameValid, data);

                        }
                    },
                    //{
                    //    "data": "CabPropertyValid", "bSortable": false, "width": "6%", "sClass": "center", render: function (data, type, row) {

                    //        return ImageColumnrenderer(data);

                    //    }
                    //},

                    // {
                    //     "data": "EmployeNoValid", "bSortable": false, "width": "6%", "sClass": "center", render: function (data, type, row) {
                    //         return ImageColumnrenderer(data);
                    //     },

                    // }
                    //,
                    {
                        "data": "RousterDate", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            if (row.RousterDate !== "" && row.RousterDate !== 'undefined' && checkdateformat(row.RousterDate))
                                validdate = true;

                            return columnrenderer(validdate, data);



                        }
                    },
                    {
                        "data": "EmployeeNo", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.EmployeNoValid, data);

                        }
                    },

                     {
                        "data": "EmployeeName", "width": "6%", "sClass": "center", render: function (data, type, row) {

                    return columnrenderer(row.EmployeeName, data);

                }
                    },
                    {
                        "data": "EmployeeGender", "width": "6%", "sClass": "center", render: function (data, type, row) {


                            if (row.EmployeeGender !== "" && row.EmployeeGender !== 'undefined' && (row.EmployeeGender == "M" || row.EmployeeGender == "F"))

                                validgender = true;
                            else
                                validgender = false;

                            return columnrenderer(validgender, data);

                        }
                    },
                    {
                        "data": "Address", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            if (row.Address != null && row.Address != undefined && row.Address.length < 50)
                                validaddress = true;
                            else {
                                validaddress = false;

                            }


                                return columnrenderer(validaddress, data);

                            }
                    },
                    {
                        "data": "Landmark", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.Landmark, data);

                                        }
                    },
                    {
                        "data": "Contact", "width": "6%", "sClass": "center", render: function (data, type, row) {


                        var isnum = /^[0-9]+$/.test(row.Contact);
                        if (row.Contact !== "" && row.Contact !== 'undefined' && (row.Contact.length == 10) && isnum)
                            validcontact = true;
                        else
                            validcontact = false;

                        return columnrenderer(validcontact, data);

                    }
                    },
                    {
                        "data": "PickupTime", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            if (row.PickupTime !== "" && row.PickupTime !== 'undefined' && checktimeformat(row.PickupTime))
                                validtime = true;
                            else
                                validtime = false;


                            return columnrenderer(validtime, data);

                        }
                    },

                    {
                        "data": "PickUpOrder", "width": "6%", "sClass": "center", render: function (data, type, row) {

                        return columnrenderer(row.PickUpOrder, data);

                    },

                    },

                    {
                        "data": "ShiftTime", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.ShiftTime, data);

                        }
                    },
                    {
                        "data": "Vendor", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.Vendor, data);

                        }
                    },
                    {
                        "data": "CabType", "width": "6%",  "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.CabType, data);

                        }
                    },
                    {
                        "data": "Signature", "width": "6%", "sClass": "center", render: function (data, type, row) {

                            return columnrenderer(row.Signature, data);

                        }
                    }

                    ],
    
                "createdRow": function (row, data, index) {
                    var validationflag = "";
                    var duplicatecount = 0;

                    if (commonRow != "" && commonRow != null) {

                        for (var i = 0; i < commonRow.length; i++) {

                        
                            if (commonRow[i].CabNo == data.cabno && commonRow[i].RoosterDate == data.RousterDate && commonRow[i].ShiftTime == data.ShiftTime ) {
                                duplicatecount = duplicatecount + 1;
                            }
                        }

                    }
             
                    validationflag = (data.CabPropertyValid && data.CabCapacityValid && data.CabnoValid && data.EmployeNoValid && data.RouteNameValid && validgender && validcontact && validdate && validtime && validaddress && (duplicatecount==0))

                    if (!validationflag)

                        $(row).css({ 'background': 'yellow' });

                }



 
    });


       
    if (roosterNumbers != null && roosterNumbers!='') {

        $('.RoosterPdf').css({ 'display': 'block' });
        $('#hdnRooster').val(roosterNumbers);
        $('.XLError').html("");
        
    }
        },
        error: function (er) {
            alert(er);
        }
    });

}

function columnrenderer(value, data) {
    if (data.trim() == "") {
        //$(".XLError").css("display", "block");
        $(".XLError").html("<b>Values can't be null</b>").css({ 'display': 'block', 'color': 'red' });
        $('.RoosterPdf').css({ 'display': 'none' });

    }
    var cssClass = "";
    if (data.length > 50)
        cssClass = "textwrap";
    else
        cssClass = "";


    var strReturn = "";
    if (value) {
        strReturn += "<label id='Active_Inactive_" + data + "' href='#' >" + data + "</label>";
    }
    else {
        strReturn += "<div id='rectangle' style=background-color:red class=" + cssClass + "><label id='Active_Inactive_" + data + "' href='#' style=color:white border:red>" + data + "</label></div>";
    }
    return strReturn;
}
function ImageColumnrenderer(data) {

    if (data == true) {
        return "<img src='../Images/true.png' height='20px' width='20px' />";
    }
    else {
        return "<img src='../Images/cross.png' height='20px' width='20px'/>";
    }


}

function checkdateformat(datestring) {



    return true;
}

function checktimeformat() {

    return true;
}

function InsertRoasterDetail(callback) {
    var roosternumbers;//local varialbe
    var insertflag;
    var commonRow;
    $.ajax({
        type: "POST",
        url: "RoosterManagement.aspx/InsertRoasterManagement",
        data: "{'rosterdetail':" + JSON.stringify('') + "}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (result) {
            var msg = result.d;
            
            insertflag = msg.Flag;
            commonRow = msg.commonrow;
            if (msg.Flag == true) {
          
                roosternumbers = msg.roosternumber;
  
            }
            else {
                // alert("Error In Process");

                roosternumbers =null;
            }   
        },
        error: function (er) {
            alert(er);
        }
    });

    return [roosternumbers, insertflag, commonRow];
}



