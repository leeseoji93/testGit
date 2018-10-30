package com.test.rememberTest.Dto;

import java.io.Serializable;
import java.sql.Date;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

public class StaffDto implements UserDetails{
	private static final long serialVersionUID = -4086869747130410600L;
	
	private String center_code;
	private String staff_id;
	private String staff_pw;
	private String staff_name;
	private String staff_phone;
	private String staff_email;
	private String staff_position;
	private String staff_charge;
	private String staff_type;
	private String registrant;
	private Date createtime;
	private Date updatetime;
	private int admin_area;
	
	
	private String mAgreeTerms;
	private String mAgreePrivacy;
	private String staff_pwCon;
	private Set<GrantedAuthority> authorities;    // 계정이 가지고 있는 권한 목록
	
	private String user_role_id;
	private String role;
	private String username;
	private String token;
	private String last_used;
	
	private String staff_phot_temp;
	
	/**반Dto**/
	private String class_name;
	private String class_id;
	private String staff_id_1;
	private String staff_id_2;
	private String class_year;
	private String class_sem;
	private String staff_phot;
	
	private String staff_phone1;
	private String staff_phone2;
	private String staff_phone3;
	
	private int kid_AllCount;
	private int staff_AllCount;
	private int parent_and_kid_AllCount_a;		//승인된 학부모
	private int parent_and_kid_AllCount_d;		//대기중인 학부모
	
	private String staffid_1;
	private String staffid_2;
	private String staffid_3;
	private String staffid_4;
	private String staffid_5;
	
	private String staff_id_type;
	
	
	public void setAuthorities(Set<GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public StaffDto() {}

		
	
	public StaffDto(String center_code, String staff_id, String staff_pw, String staff_name, String staff_phone,
			String staff_email, String staff_position, String staff_charge, String staff_type, String registrant,
			Date createtime, Date updatetime, int admin_area, String mAgreeTerms, String mAgreePrivacy,
			String staff_pwCon, Set<GrantedAuthority> authorities) {
		super();
		this.center_code = center_code;
		this.staff_id = staff_id;
		this.staff_pw = staff_pw;
		this.staff_name = staff_name;
		this.staff_phone = staff_phone;
		this.staff_email = staff_email;
		this.staff_position = staff_position;
		this.staff_charge = staff_charge;
		this.staff_type = staff_type;
		this.registrant = registrant;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.admin_area = admin_area;
		this.mAgreeTerms = mAgreeTerms;
		this.mAgreePrivacy = mAgreePrivacy;
		this.staff_pwCon = staff_pwCon;
		this.authorities = authorities;
	}

	public String getCenter_code() {
		return center_code;
	}

	public void setCenter_code(String center_code) {
		this.center_code = center_code;
	}

	public String getStaff_id() {
		return staff_id;
	}

	public void setStaff_id(String staff_id) {
		this.staff_id = staff_id;
	}

	public String getStaff_pw() {
		return staff_pw;
	}

	public void setStaff_pw(String staff_pw) {
		this.staff_pw = staff_pw;
	}

	public String getStaff_name() {
		return staff_name;
	}

	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}

	public String getStaff_phone() {
		return staff_phone;
	}

	public void setStaff_phone(String staff_phone) {
		this.staff_phone = staff_phone;
	}

	public String getStaff_email() {
		return staff_email;
	}

	public void setStaff_email(String staff_email) {
		this.staff_email = staff_email;
	}

	public String getStaff_position() {
		return staff_position;
	}

	public void setStaff_position(String staff_position) {
		this.staff_position = staff_position;
	}

	public String getStaff_charge() {
		return staff_charge;
	}

	public void setStaff_charge(String staff_charge) {
		this.staff_charge = staff_charge;
	}

	public String getStaff_type() {
		return staff_type;
	}

	public void setStaff_type(String staff_type) {
		this.staff_type = staff_type;
	}

	public String getRegistrant() {
		return registrant;
	}

	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public int getAdmin_area() {
		return admin_area;
	}

	public void setAdmin_area(int admin_area) {
		this.admin_area = admin_area;
	}

	public String getmAgreeTerms() {
		return mAgreeTerms;
	}

	public void setmAgreeTerms(String mAgreeTerms) {
		this.mAgreeTerms = mAgreeTerms;
	}

	public String getmAgreePrivacy() {
		return mAgreePrivacy;
	}

	public void setmAgreePrivacy(String mAgreePrivacy) {
		this.mAgreePrivacy = mAgreePrivacy;
	}

	public String getStaff_pwCon() {
		return staff_pwCon;
	}

	public void setStaff_pwCon(String staff_pwCon) {
		this.staff_pwCon = staff_pwCon;
	}

	public Set<GrantedAuthority> getAuthorities() {
		return authorities;
	}

	public String getUser_role_id() {
		return user_role_id;
	}

	public void setUser_role_id(String user_role_id) {
		this.user_role_id = user_role_id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getLast_used() {
		return last_used;
	}

	public void setLast_used(String last_used) {
		this.last_used = last_used;
	}

	public String getStaff_phot_temp() {
		return staff_phot_temp;
	}

	public void setStaff_phot_temp(String staff_phot_temp) {
		this.staff_phot_temp = staff_phot_temp;
	}

	@Override
	public String getPassword() {
		return staff_pw;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
	private static SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities) {
        Assert.notNull(authorities, "Cannot pass a null GrantedAuthority collection");
        // Ensure array iteration order is predictable (as per UserDetails.getAuthorities() contract and SEC-717)
        SortedSet<GrantedAuthority> sortedAuthorities =
            new TreeSet<GrantedAuthority>(new AuthorityComparator());
 
        for (GrantedAuthority grantedAuthority : authorities) {
            Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
            sortedAuthorities.add(grantedAuthority);
        }
 
        return sortedAuthorities;
    }
     
    private static class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable {
        private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
 
        public int compare(GrantedAuthority g1, GrantedAuthority g2) {
            // Neither should ever be null as each entry is checked before adding it to the set.
            // If the authority is null, it is a custom authority and should precede others.
            if (g2.getAuthority() == null) {
                return -1;
            }
 
            if (g1.getAuthority() == null) {
                return 1;
            }
 
            return g1.getAuthority().compareTo(g2.getAuthority());
        }
    }

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getStaff_id_1() {
		return staff_id_1;
	}

	public void setStaff_id_1(String staff_id_1) {
		this.staff_id_1 = staff_id_1;
	}

	public String getStaff_id_2() {
		return staff_id_2;
	}

	public void setStaff_id_2(String staff_id_2) {
		this.staff_id_2 = staff_id_2;
	}

	public String getClass_year() {
		return class_year;
	}

	public void setClass_year(String class_year) {
		this.class_year = class_year;
	}

	public String getClass_sem() {
		return class_sem;
	}

	public void setClass_sem(String class_sem) {
		this.class_sem = class_sem;
	}

	public String getStaff_phot() {
		return staff_phot;
	}

	public void setStaff_phot(String staff_phot) {
		this.staff_phot = staff_phot;
	}

	public String getStaff_phone1() {
		return staff_phone1;
	}

	public void setStaff_phone1(String staff_phone1) {
		this.staff_phone1 = staff_phone1;
	}

	public String getStaff_phone2() {
		return staff_phone2;
	}

	public void setStaff_phone2(String staff_phone2) {
		this.staff_phone2 = staff_phone2;
	}

	public String getStaff_phone3() {
		return staff_phone3;
	}

	public void setStaff_phone3(String staff_phone3) {
		this.staff_phone3 = staff_phone3;
	}

	public int getKid_AllCount() {
		return kid_AllCount;
	}

	public void setKid_AllCount(int kid_AllCount) {
		this.kid_AllCount = kid_AllCount;
	}

	public int getStaff_AllCount() {
		return staff_AllCount;
	}

	public void setStaff_AllCount(int staff_AllCount) {
		this.staff_AllCount = staff_AllCount;
	}

	public int getParent_and_kid_AllCount_a() {
		return parent_and_kid_AllCount_a;
	}

	public void setParent_and_kid_AllCount_a(int parent_and_kid_AllCount_a) {
		this.parent_and_kid_AllCount_a = parent_and_kid_AllCount_a;
	}

	public int getParent_and_kid_AllCount_d() {
		return parent_and_kid_AllCount_d;
	}

	public void setParent_and_kid_AllCount_d(int parent_and_kid_AllCount_d) {
		this.parent_and_kid_AllCount_d = parent_and_kid_AllCount_d;
	}

	public String getStaffid_1() {
		return staffid_1;
	}

	public void setStaffid_1(String staffid_1) {
		this.staffid_1 = staffid_1;
	}

	public String getStaffid_2() {
		return staffid_2;
	}

	public void setStaffid_2(String staffid_2) {
		this.staffid_2 = staffid_2;
	}

	public String getStaffid_3() {
		return staffid_3;
	}

	public void setStaffid_3(String staffid_3) {
		this.staffid_3 = staffid_3;
	}

	public String getStaffid_4() {
		return staffid_4;
	}

	public void setStaffid_4(String staffid_4) {
		this.staffid_4 = staffid_4;
	}

	public String getStaffid_5() {
		return staffid_5;
	}

	public void setStaffid_5(String staffid_5) {
		this.staffid_5 = staffid_5;
	}

	public String getStaff_id_type() {
		return staff_id_type;
	}

	public void setStaff_id_type(String staff_id_type) {
		this.staff_id_type = staff_id_type;
	}

}
