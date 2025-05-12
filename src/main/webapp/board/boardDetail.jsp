<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardVO" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <%request.setCharacterEncoding("UTF-8"); %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행 이야기 상세</title>
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

        .travel_info {
            margin: 30px 0;
            padding: 20px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .info_item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            transition: var(--transition);
        }

        .info_item:hover {
            background-color: #f1f8e9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .info_icon {
            width: 20px;
            height: 20px;
            fill: var(--main-color);
        }

        .info_label {
            font-weight: 600;
            color: var(--main-color);
            white-space: nowrap;
        }

        .info_value {
            color: var(--text-color);
        }

        .info_value.budget {
            color: #e74c3c;
            font-weight: 600;
        }

        .content_main {
            margin: 30px 0;
            padding: 30px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            min-height: 300px;
            display: flex;
            flex-direction: column;
        }

        .content_main p {
            flex: 1;
            margin: 0;
            padding: 20px;
            line-height: 1.8;
            color: var(--text-color);
            font-size: 1.1rem;
            white-space: pre-wrap;
            word-break: break-word;
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

        .updateBtn {
            background-color: var(--main-color);
            color: white;
        }

        .updateBtn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .deleteBtn {
            background-color: #dc3545;
            color: white;
        }

        .deleteBtn:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .meta_info {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .metaItem {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            transition: var(--transition);
            color: #6c757d;
        }

        .metaItem:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .metaIcon {
            width: 18px;
            height: 18px;
            fill: currentColor;
        }

        .likeBtn {
            text-decoration: none;
            color: #6c757d;
            transition: var(--transition);
            background-color: white;
            border-radius: 20px;
            padding: 8px 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .likeBtn:hover {
            color: #e74c3c;
            background-color: #fff5f5;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .likeBtn .metaIcon {
            transition: var(--transition);
        }

        .likeBtn:hover .metaIcon {
            fill: #e74c3c;
            transform: scale(1.1);
        }

        @media (max-width: 768px) {
            .content {
                width: 95%;
                padding: 20px;
            }

            .mainTitle {
                font-size: 2rem;
            }

            .travel_info {
                flex-direction: column;
                gap: 10px;
            }

            .info_item {
                width: 100%;
                justify-content: center;
            }

            .bottom_area {
                flex-direction: column;
            }

            .bottom_area .btn {
                width: 100%;
            }

            .meta_info {
                flex-wrap: wrap;
            }

            .metaItem, .likeBtn {
                flex: 1;
                min-width: 120px;
                justify-content: center;
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
        <span class="mainTitle">여행 이야기 상세</span>

        <div class="title">
            <span class="subTitle">제목: </span>
            <%=boardVO.getBoardTitle()%>
        </div>

        <div class="travel_info">
            <div class="info_item">
                <svg class="info_icon" viewBox="0 0 24 24">
                    <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                </svg>
                <span class="info_label">여행지</span>
                <span class="info_value"><%=boardVO.getTravelLocation()%></span>
            </div>
            <div class="info_item">
                <svg class="info_icon" viewBox="0 0 24 24">
                    <path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z"/>
                </svg>
                <span class="info_label">여행기간</span>
                <span class="info_value"><%=boardVO.getTravelPeriod()%></span>
            </div>
            <div class="info_item">
                <svg class="info_icon" viewBox="0 0 24 24">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.31-8.86c-1.77-.45-2.34-.94-2.34-1.67 0-.84.79-1.43 2.1-1.43 1.38 0 1.9.66 1.94 1.64h1.71c-.05-1.34-.87-2.57-2.49-2.97V5H10.9v1.69c-1.51.32-2.72 1.3-2.72 2.81 0 1.79 1.49 2.69 3.66 3.21 1.95.46 2.34 1.15 2.34 1.87 0 .53-.39 1.39-2.1 1.39-1.6 0-2.23-.72-2.32-1.64H8.04c.1 1.7 1.36 2.66 2.86 2.97V19h2.34v-1.67c1.52-.29 2.72-1.16 2.73-2.77-.01-2.2-1.9-2.96-3.66-3.42z"/>
                </svg>
                <span class="info_label">예산</span>
                <span class="info_value budget">
                    <%
                        int budget = boardVO.getTravelBudget();
                        String budgetRange;
                        if (budget <= 100000) {
                            budgetRange = "10만원 이하";
                        } else if (budget <= 300000) {
                            budgetRange = "10만원 ~ 30만원";
                        } else if (budget <= 500000) {
                            budgetRange = "30만원 ~ 50만원";
                        } else if (budget <= 1000000) {
                            budgetRange = "50만원 ~ 100만원";
                        } else if (budget <= 2000000) {
                            budgetRange = "100만원 ~ 200만원";
                        } else if (budget <= 3000000) {
                            budgetRange = "200만원 ~ 300만원";
                        } else if (budget <= 5000000) {
                            budgetRange = "300만원 ~ 500만원";
                        } else if (budget <= 10000000) {
                            budgetRange = "500만원 ~ 1000만원";
                        } else if (budget <= 20000000) {
                            budgetRange = "1000만원 ~ 2000만원";
                        } else if (budget <= 30000000) {
                            budgetRange = "2000만원 ~ 3000만원";
                        } else if (budget <= 50000000) {
                            budgetRange = "3000만원 ~ 5000만원";
                        } else {
                            budgetRange = "5000만원 이상";
                        }
                        out.print(budgetRange);
                    %>
                </span>
            </div>
        </div>

        <div class="content_main">
            <%=boardVO.getBoardContent()%>
        </div>

        <div class="meta_info">
            <div class="metaItem">
                <svg class="metaIcon" viewBox="0 0 24 24">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.31-8.86c-1.77-.45-2.34-.94-2.34-1.67 0-.84.79-1.43 2.1-1.43 1.38 0 1.9.66 1.94 1.64h1.71c-.05-1.34-.87-2.57-2.49-2.97V5H10.9v1.69c-1.51.32-2.72 1.3-2.72 2.81 0 1.79 1.49 2.69 3.66 3.21 1.95.46 2.34 1.15 2.34 1.87 0 .53-.39 1.39-2.1 1.39-1.6 0-2.23-.72-2.32-1.64H8.04c.1 1.7 1.36 2.66 2.86 2.97V19h2.34v-1.67c1.52-.29 2.72-1.16 2.73-2.77-.01-2.2-1.9-2.96-3.66-3.42z"/>
                </svg>
                조회수 <%=boardVO.getViewCount()%>
            </div>
            <a href="like.co?board_idx=<%=boardVO.getBoardIdx()%>" class="likeBtn">
                <svg class="metaIcon" viewBox="0 0 24 24">
                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                </svg>
                좋아요 <%=boardVO.getLikeCount()%>
            </a>
        </div>

        <div class="bottom_area">
            <input type="button" class="listBtn btn" value="목록으로" onclick="boardList()">
            <%
                String userId = (String) session.getAttribute("userId");
                if (userId != null && userId.equals(boardVO.getInstUser())) {
            %>
                <input type="button" id = "hidden_button" class="updateBtn btn" value="수정하기" onclick="boardUpdate()">
                <input type="button" id = "hidden_button" class="deleteBtn btn" value="삭제하기" onclick="boardDelete()">
            <% } %>
        </div>
    </div>

    <script>
        function boardList() {
            location.href="./list.co";    
        }
        
        function boardUpdate() {
            location.href="./update.co?board_idx=<%=boardVO.getBoardIdx()%>";    
        }
        
        function boardDelete() {
            if(confirm("정말로 삭제하시겠습니까?")) {
                location.href="./deleteAction.co?board_idx=<%=boardVO.getBoardIdx()%>";    
            }
        }
    </script>
</body>
</html>