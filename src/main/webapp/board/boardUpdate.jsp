<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardVO" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <%request.setCharacterEncoding("UTF-8"); %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행 이야기 수정</title>
    <style>
        :root {
            --main-color: #4CAF50;
            --secondary-color: #8BC34A;
            --accent-color: #FFC107;
            --text-color: #333;
            --light-bg: #f9f9f9;
            --border-radius: 12px;
            --box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: var(--light-bg);
            background-image: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            min-height: 100vh;
        }

        .content {
            margin: 30px auto;
            padding: 40px;
            width: 90%;
            max-width: 1200px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            backdrop-filter: blur(10px);
        }

        .mainTitle {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--main-color);
            margin-bottom: 40px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .content .title {
            margin: 25px 0;
            padding: 25px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .content .title:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .content .subTitle {
            font-size: 1.2rem;
            color: var(--text-color);
            margin-right: 15px;
            font-weight: 500;
        }

        .content input[type="text"],
        .content input[type="number"] {
            width: 80%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: #f8f9fa;
        }

        .content input[type="text"]:focus,
        .content input[type="number"]:focus {
            border-color: var(--main-color);
            outline: none;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .travel_info {
            margin: 30px 0;
            padding: 25px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .info_item {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            transition: var(--transition);
        }

        .info_item:hover {
            transform: translateX(5px);
            background-color: #f1f8e9;
        }

        .info_item:last-child {
            margin-bottom: 0;
        }

        .budget_input {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .budget_input select {
            width: 200px;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background-color: #f8f9fa;
            cursor: pointer;
        }

        .budget_input select:focus {
            border-color: var(--main-color);
            outline: none;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        /* 카테고리 select box 스타일 */
        .info_item select {
            width: 200px;
            padding: 12px 40px 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%234CAF50' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .info_item select:hover {
            border-color: var(--main-color);
            background-color: #f1f8e9;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(76, 175, 80, 0.1);
        }

        .info_item select:focus {
            border-color: var(--main-color);
            outline: none;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
            transform: translateY(-1px);
        }

        .info_item select option {
            padding: 12px 15px;
            background-color: white;
            color: #333;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .info_item select option:hover {
            background-color: #f1f8e9;
            color: var(--main-color);
        }

        .info_item select option:checked {
            background-color: var(--main-color);
            color: white;
        }

        /* 카테고리 라벨 스타일 */
        .info_item .subTitle {
            font-weight: 600;
            color: #2c3e50;
            margin-right: 20px;
            min-width: 80px;
        }

        /* 카테고리 컨테이너 스타일 */
        .info_item {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s ease;
            border: 1px solid #e0e0e0;
        }

        .info_item:hover {
            transform: translateX(5px);
            background-color: #f1f8e9;
            border-color: var(--main-color);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.1);
        }

        .budget_unit {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .content_main {
            margin: 30px 0;
            padding: 30px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .content_main textarea {
            width: 100%;
            height: 400px;
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            line-height: 1.6;
            resize: none;
            transition: var(--transition);
            background-color: #f8f9fa;
        }

        .content_main textarea:focus {
            border-color: var(--main-color);
            outline: none;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .bottom_area {
            display: flex;
            justify-content: flex-end;
            margin-top: 30px;
            gap: 15px;
        }

        .bottom_area .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .listBtn {
            background-color: #6c757d;
            color: white;
        }

        .listBtn:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .resultBtn {
            background-color: var(--main-color);
            color: white;
        }

        .resultBtn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        @media (max-width: 768px) {
            .content {
                width: 95%;
                padding: 20px;
            }

            .mainTitle {
                font-size: 2rem;
            }

            .content input[type="text"],
            .content input[type="number"] {
                width: 100%;
            }

            .info_item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .bottom_area {
                flex-direction: column;
            }

            .bottom_area .btn {
                width: 100%;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>

<body>
<%
    BoardVO boardVO = (BoardVO) request.getAttribute("boardVO");
%>
    <div class="content">
        <span class="mainTitle">여행 이야기 수정</span>

        <form action="updateAction.co" method="post">
            <input type="hidden" name="board_idx" value="<%=boardVO.getBoardIdx()%>">
            
            <div class="title">
                <span class="subTitle">제목: </span>
                <input type="text" name="board_title" value="<%=boardVO.getBoardTitle()%>">
            </div>

            <div class="travel_info">
                <div class="info_item">
                    <span class="subTitle">카테고리: </span>
                    <select name="board_category">
                        <option value="국내여행" <%=boardVO.getBoardCategory().equals("국내여행") ? "selected" : ""%>>국내여행</option>
                        <option value="해외여행" <%=boardVO.getBoardCategory().equals("해외여행") ? "selected" : ""%>>해외여행</option>
                        <option value="맛집" <%=boardVO.getBoardCategory().equals("맛집") ? "selected" : ""%>>맛집</option>
                        <option value="숙소" <%=boardVO.getBoardCategory().equals("숙소") ? "selected" : ""%>>숙소</option>
                    </select>
                </div>
                <div class="info_item">
                    <span class="subTitle">여행지: </span>
                    <input type="text" name="travel_location" value="<%=boardVO.getTravelLocation()%>">
                </div>
                <div class="info_item">
                    <span class="subTitle">여행기간: </span>
                    <input type="text" name="travel_period" value="<%=boardVO.getTravelPeriod()%>">
                </div>
                <div class="info_item">
                    <span class="subTitle">예산: </span>
                    <div class="budget_input">
                        <select name="travel_budget" id="travelBudget" required>
                            <option value="">예산을 선택하세요</option>
                            <option value="100000" <%=boardVO.getTravelBudget() == 100000 ? "selected" : ""%>>10만원 이하</option>
                            <option value="300000" <%=boardVO.getTravelBudget() == 300000 ? "selected" : ""%>>10만원 ~ 30만원</option>
                            <option value="500000" <%=boardVO.getTravelBudget() == 500000 ? "selected" : ""%>>30만원 ~ 50만원</option>
                            <option value="1000000" <%=boardVO.getTravelBudget() == 1000000 ? "selected" : ""%>>50만원 ~ 100만원</option>
                            <option value="2000000" <%=boardVO.getTravelBudget() == 2000000 ? "selected" : ""%>>100만원 ~ 200만원</option>
                            <option value="3000000" <%=boardVO.getTravelBudget() == 3000000 ? "selected" : ""%>>200만원 ~ 300만원</option>
                            <option value="5000000" <%=boardVO.getTravelBudget() == 5000000 ? "selected" : ""%>>300만원 ~ 500만원</option>
                            <option value="10000000" <%=boardVO.getTravelBudget() == 10000000 ? "selected" : ""%>>500만원 ~ 1000만원</option>
                            <option value="20000000" <%=boardVO.getTravelBudget() == 20000000 ? "selected" : ""%>>1000만원 ~ 2000만원</option>
                            <option value="30000000" <%=boardVO.getTravelBudget() == 30000000 ? "selected" : ""%>>2000만원 ~ 3000만원</option>
                            <option value="50000000" <%=boardVO.getTravelBudget() == 50000000 ? "selected" : ""%>>3000만원 ~ 5000만원</option>
                            <option value="100000000" <%=boardVO.getTravelBudget() == 100000000 ? "selected" : ""%>>5000만원 이상</option>
                        </select>
                        <span class="budget_unit">원</span>
                    </div>
                    <div id="budgetDisplay" class="budget_display"></div>
                </div>
            </div>

            <div class="content_main">
                <textarea name="board_content"><%=boardVO.getBoardContent()%></textarea>
            </div>

            <div class="bottom_area">
                <input type="button" class="listBtn btn" value="목록으로" onclick="boardList()">
                <input type="submit" class="resultBtn btn" value="글 수정">
            </div>
        </form>
    </div>

    <script>
        function boardList() {
            location.href="./list.co";    
        }
    </script>
</body>
</html>