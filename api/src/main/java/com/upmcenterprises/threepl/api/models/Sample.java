package com.upmcenterprises.threepl.api.models;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "sample")
public class Sample {
  
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Column(name = "sample_id")
  private Long id;
  
  @NotNull
  private String name;
  
  @Column(name = "start_date")
  private Date startDate;
  
  @Column(name = "end_date")
  private Date endDate;
  
  @NotNull
  private String description;
  
  public Long getId() {
    return id;
  }
  
  public void setId(Long id) {
    this.id = id;
  }
  
  public String getName() {
    return name;
  }
  
  public void setName(String name) {
    this.name = name;
  }
  
  public Date getStartDate() {
    return startDate;
  }
  
  public void setStartDate(Date startDate) {
    this.startDate = startDate;
  }
  
  public Date getEndDate() {
    return endDate;
  }
  
  public void setEndDate(Date endDate) {
    this.endDate = endDate;
  }
  
  public String getDescription() {
    return description;
  }
  
  public void setDescription(String description) {
    this.description = description;
  }
  
  @Override
  public int hashCode() {
    return new HashCodeBuilder()
        .append(this.getId())
        .append(this.getName())
        .append(this.getStartDate())
        .append(this.getEndDate())
        .append(this.getDescription())
        .toHashCode();
  }
  
  @Override
  public boolean equals(Object object) {
    if (this == object) {
      return true;
    }
  
    if (object == null) {
      return false;
    }
  
    if (getClass() != object.getClass()) {
      return false;
    }
  
    Sample other = (Sample) object;
    return new EqualsBuilder()
               .append(this.getId(), other.getId())
               .append(this.getName(), other.getName())
               .append(this.getStartDate(), other.getStartDate())
               .append(this.getEndDate(), other.getEndDate())
               .append(this.getDescription(), other.getDescription())
               .isEquals();
  }
  
  @Override
  public String toString() {
    return new ToStringBuilder(this)
               .append("id", this.id)
               .append("name", this.name)
               .append("startDate", this.startDate)
               .append("endDate", this.endDate)
               .append("description", this.description)
               .toString();
  }
}
