export const smallMaxWidth = 680;

export const large = `only screen and (min-width: ${smallMaxWidth + 1}px)`;
export const small = `only screen and (max-width: ${smallMaxWidth}px)`;

export const touch = `only screen and (hover: none)`;
export const mouse = `only screen and (hover: hover)`;

export const between = (x, y) => `only screen and (min-width: ${x}px) and (max-width: ${y}px)`;
