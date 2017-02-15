package com.upmcenterprises.threepl.api.models;

import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;

@Transactional
public interface SampleRepository extends JpaRepository<Sample, Long> {}


