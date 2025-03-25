package EcartDetailsDTO;

import java.security.Timestamp;

public class EcartDetailsDTO {
	private Integer userId;
    private String userType;
    private Timestamp timestamp;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer integer) {
        this.userId = integer;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

	public void setTimestamp(java.sql.Timestamp currentTimestamp) {
		// TODO Auto-generated method stub
		
	}
}
