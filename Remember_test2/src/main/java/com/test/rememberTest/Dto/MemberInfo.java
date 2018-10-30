package com.test.rememberTest.Dto;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.persistence.*;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

@Entity
@Table(name = "MEMBERINFO")
public class MemberInfo implements UserDetails{
	 
    private static final long serialVersionUID = -4086869747130410600L;
    
    private String center_code;
    private String staff_id;
    private String staff_pw;
    private String staff_name;
    private String staff_phone;
    private String staff_email;
    private String staff_postion;
    private String staff_charge;
    private String staff_type;
    private String registrant;
    private String createtime;
    private String updatetime;
    
    public MemberInfo(String username, String password,String name ,Collection<? extends GrantedAuthority> authorities){
        this.staff_id = username;
        this.staff_pw = password;
        this.staff_name = name;
        this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
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

	public String getStaff_postion() {
		return staff_postion;
	}

	public void setStaff_postion(String staff_postion) {
		this.staff_postion = staff_postion;
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

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	public void setChk_id(String chk_id) {
		this.chk_id = chk_id;
	}

	public void setAuthorities(Set<GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	@Column(name="mAgreeTerms")
   // @NotBlank		(message="약관 동의해 주세요.")
    private String mAgreeTerms;
    
    @Column(name="mAgreePrivacy")
   // @NotBlank		(message="개인정보 이용 동의해 주세요.")
    private String mAgreePrivacy;
    
    private String chk_id;
    
    private Set<GrantedAuthority> authorities;    // 계정이 가지고 있는 권한 목록
    
   
    
    public MemberInfo() {
		// TODO Auto-generated constructor stub
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
	public String getChk_id() {
		return chk_id;
	}
	public void setChchk_id(String chk_id) {
		this.chk_id = chk_id;
	}

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // TODO Auto-generated method stub
        return authorities;
    }
     
    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
    }
     
 
    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return staff_pw;
    }
 
    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return getStaff_id();
    }
 
    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }
 
    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return true;
    }
 
    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return true;
    }
 
    @Override
    public boolean isEnabled() {
        // TODO Auto-generated method stub
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
 
}