using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Diagnostics;

namespace WebApplication1
{
    /// <summary>
    /// Summary description for Upload
    /// </summary>
    public class Upload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType = "text/plain";
            context.Response.Expires = -1;
            try
            {
                HttpPostedFile postedFile = context.Request.Files[0];
                string savepath = "";
                string tempPath = "";
                tempPath = System.Configuration.ConfigurationManager.AppSettings["FolderPath"];
                savepath = context.Server.MapPath(tempPath);
                string filename =postedFile.FileName;
                int index = filename.LastIndexOf("\\");
                filename = filename.Substring(index + 1);
                if (!Directory.Exists(savepath))
                {
                    Directory.CreateDirectory(savepath);
                }

                string combinepath = savepath + "\\"+filename;
                if (File.Exists(combinepath))
                {
                    KillExcelProcessThatUsedByThisInstance();
                    File.Delete(combinepath);
                }

                // Save file
              
                postedFile.SaveAs(combinepath);//(savepath + @"\" + filename);
                context.Response.Write(tempPath + "/" + filename);
                context.Response.StatusCode = 200;
            }
            catch (Exception ex)
            {
                context.Response.Write("Error: " + ex.Message);
            }
        }
        void KillExcelProcessThatUsedByThisInstance()
        {
            Process[] AllProcesses = Process.GetProcessesByName("excel");

            if (AllProcesses.Length != 0)
            {
                AllProcesses[0].Kill();

                AllProcesses = null;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}