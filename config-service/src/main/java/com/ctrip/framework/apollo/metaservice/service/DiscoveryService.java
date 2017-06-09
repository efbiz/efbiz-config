package com.ctrip.framework.apollo.metaservice.service;

import com.ctrip.framework.apollo.core.ServiceNameConsts;
import com.ctrip.framework.apollo.tracer.Tracer;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DiscoveryService {

  @Autowired
  private EurekaClient eurekaClient;

  public List<InstanceInfo> getConfigServiceInstances() {
    Application application = eurekaClient.getApplication(ServiceNameConsts.CONFIGSERVICE);
    if (application == null) {
      Tracer.logEvent("Config.EurekaDiscovery.NotFound", ServiceNameConsts.CONFIGSERVICE);
    }
    return application != null ? application.getInstances() : new ArrayList<>();
  }

  public List<InstanceInfo> getMetaServiceInstances() {
    Application application = eurekaClient.getApplication(ServiceNameConsts.METASERVICE);
    if (application == null) {
      Tracer.logEvent("Config.EurekaDiscovery.NotFound", ServiceNameConsts.METASERVICE);
    }
    return application != null ? application.getInstances() : new ArrayList<>();
  }

  public List<InstanceInfo> getAdminServiceInstances() {
    Application application = eurekaClient.getApplication(ServiceNameConsts.CONFIGADMIN);
    if (application == null) {
      Tracer.logEvent("Config.EurekaDiscovery.NotFound", ServiceNameConsts.CONFIGADMIN);
    }
    return application != null ? application.getInstances() : new ArrayList<>();
  }
}
