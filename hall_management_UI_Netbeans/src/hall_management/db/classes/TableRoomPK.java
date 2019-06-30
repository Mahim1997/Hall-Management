/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hall_management.db.classes;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author suban
 */
@Embeddable
public class TableRoomPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "HALL_ID")
    private long hallId;
    @Basic(optional = false)
    @Column(name = "ROOM_NO")
    private long roomNo;

    public TableRoomPK() {
    }

    public TableRoomPK(long hallId, long roomNo) {
        this.hallId = hallId;
        this.roomNo = roomNo;
    }

    public long getHallId() {
        return hallId;
    }

    public void setHallId(long hallId) {
        this.hallId = hallId;
    }

    public long getRoomNo() {
        return roomNo;
    }

    public void setRoomNo(long roomNo) {
        this.roomNo = roomNo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) hallId;
        hash += (int) roomNo;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TableRoomPK)) {
            return false;
        }
        TableRoomPK other = (TableRoomPK) object;
        if (this.hallId != other.hallId) {
            return false;
        }
        if (this.roomNo != other.roomNo) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "hall_management.db.classes.TableRoomPK[ hallId=" + hallId + ", roomNo=" + roomNo + " ]";
    }
    
}
