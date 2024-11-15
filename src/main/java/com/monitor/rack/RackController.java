package com.monitor.rack;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/rack")
public class RackController {
    @GetMapping("/{nodeName}")
    public String PopUpPage(
            Model model) {


// 		Properties property = System.getProperties();

        //property.setProperty("org.omg.CORBA.ORBClass", "org.jacorb.orb.ORB");
        //property.setProperty("org.omg.CORBA.ORBSingletonClass", "org.jacorb.orb.ORBSingleton");

//		ProcDomain proc = procBo.getProcIor("SGS");
//		LOGGER.info(proc.getProcIor());
//
//		ORB orb = ORB.init(new String[0], property);
//		org.omg.CORBA.Object obj = orb.string_to_object(proc.getProcIor());
//		TGWIf tgwIf = TGWIfHelper.narrow(obj);
//
//		BOARDIdx varBOARDIdx = new BOARDIdx();
//		varBOARDIdx.nodeId = 169083848;
//
//		SLOTConfigListHolder varSLOTConfigList = new SLOTConfigListHolder();
//		StringHolder reason = new StringHolder();
//		int ret = tgwIf.getSLOT(varBOARDIdx, varSLOTConfigList, reason);
//
//		LOGGER.info("ret : " + ret );
//
//		model.addAttribute("SlotConfig", varSLOTConfigList);

        return "rack/rackNode";
    }
}
