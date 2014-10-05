package org.app.util;

import java.io.Serializable;

public class GroupMember implements Serializable {
 
  private static final long serialVersionUID = 1L;
  private String[] selectedIds;

  public String[] getSelectedIds() {
      return selectedIds;
  }

  public void setSelectedIds(String[] selectedIds) {
      this.selectedIds = selectedIds;
  }
}