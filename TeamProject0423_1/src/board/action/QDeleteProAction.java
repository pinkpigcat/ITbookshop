package board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.QDeleteProService;
import vo.ActionForward;

public class QDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		int result=0;
		int boardNum=Integer.parseInt(request.getParameter("boardNum"));
		QDeleteProService q_DeleteProService = new QDeleteProService();
		result=q_DeleteProService.deleteOneOnOne(boardNum);
		
		
		
		
		forward = new ActionForward();
		forward.setPath("QList.bo");
		forward.setRedirect(true);
		return forward;
	}

}
