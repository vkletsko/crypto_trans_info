import React from 'react'
import "./Notification.css"

import { useState } from "react";

interface Props {
    message: string;
}

export const Notification = (props: Props) => {
    const [isShow, setIsShow] = useState(true);


    const handleClose = (e: React.MouseEvent) => {
        e.preventDefault();

        setIsShow(false);
      };

    return (
        
        <div className="alert" style={ isShow ? {} : { display: 'none' } }>
            <span className="closebtn" onClick={ handleClose }>&times;</span>
            {props.message}
        </div>
    );
}