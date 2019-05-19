/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package QuanLy;

/**
 *
 * @author USER
 */
public class HocSinh {
    private String maSo,hoTen,diaChi,gioiTinh, ngaySinh;
    private int khoi;
    private float diemkh1, diemhk2, diemtk;

    public float getDiemkh1() {
        return diemkh1;
    }

    public void setDiemkh1(float diemkh1) {
        this.diemkh1 = diemkh1;
    }

    public float getDiemhk2() {
        return diemhk2;
    }

    public void setDiemhk2(float diemhk2) {
        this.diemhk2 = diemhk2;
    }

    public float getDiemtk() {
        return diemtk;
    }

    public void setDiemtk(float diemtk) {
        this.diemtk = diemtk;
    }

    

    public String getMaSo() {
        return maSo;
    }

    public void setMaSo(String maSo) {
        this.maSo = maSo;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public int getKhoi() {
        return khoi;
    }

    public void setKhoi(int khoi) {
        this.khoi = khoi;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    
    


    public HocSinh() {
    }
    
    public Object[] toArray(){
        return new Object[]{maSo,hoTen,khoi};
    }

    public HocSinh(String maSo, String hoTen, int khoi) {
        this.maSo = maSo;
        this.hoTen = hoTen;
        this.khoi = khoi;
    }

    
    public HocSinh(HocSinh a) {
        this.maSo = a.maSo;
        this.hoTen = a.hoTen;
        this.khoi = a.khoi;
    }
    
    public HocSinh(String maSo) {
        this.maSo = maSo;       
    }

    public HocSinh(String maSo, String hoTen, String gioiTinh, String ngaySinh) {
        this.maSo = maSo;
        this.hoTen = hoTen;
        this.diaChi = "";
        this.gioiTinh = gioiTinh;
        this.ngaySinh = ngaySinh;
        this.khoi = 0;
    }

    public HocSinh(String maSo, String hoTen, String diaChi, String gioiTinh, String namSinh, int khoi, float diemkh1, float diemhk2, float diemtk) {
        this.maSo = maSo;
        this.hoTen = hoTen;
        this.diaChi = diaChi;
        this.gioiTinh = gioiTinh;
        this.ngaySinh = namSinh;
        this.khoi = khoi;
        this.diemkh1 = diemkh1;
        this.diemhk2 = diemhk2;
        this.diemtk = diemtk;
    }
    

    
    public Object[] toArrayAll(){
        return new Object[]{maSo,hoTen,diaChi,gioiTinh,ngaySinh};
    }
}
