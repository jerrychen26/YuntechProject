/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package json;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author webserver
 */
@WebServlet(name = "getAll", urlPatterns = {"/getAll"})
public class getAll2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Configuration conf = null;
        conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", "master");
        String tablename=null;
        tablename=request.getParameter("tablename");
        tablename="drone";
        String row = null,family=null,qualifier=null,value=null;

        HashMap userInfoMap = new HashMap();
        //Map<String, Object> map = new HashMap<String, Object>();
        
        
        try {
            HTable table = new HTable(conf, tablename);
            Scan s = new Scan();
            ResultScanner ss = table.getScanner(s);   
            for(Result r:ss){
                for(KeyValue kv : r.raw()){
                    row=new String(kv.getRow());
                    userInfoMap.put("RowKey", row);
                    //map.put("RowKey", row);
                    
                    family=new String(kv.getFamily());
                    userInfoMap.put("Family", family);
                    //map.put("Family", family);
                    
                    qualifier=new String(kv.getQualifier());
                    userInfoMap.put("Qualifier", qualifier);
                    //map.put("Qualifier", qualifier);
                    
                    value=new String(kv.getValue());
                    userInfoMap.put("Value", value);
                    //map.put("Value", value);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
         
        
       String call = request.getParameter("callback");
        //JSONArray jsonArray = new JSONArray(userInfoMap);  ;
        JSONObject responseJSONObject = new JSONObject(userInfoMap);
        PrintWriter out = response.getWriter();
        out.print(call+"("+responseJSONObject+")");
        }
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
